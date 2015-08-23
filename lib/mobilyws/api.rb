require 'open-uri'
require 'net/http'
require 'net/https'

module Mobilyws
  
  class API
    attr_reader :username, :password, :sender_name
  
    def initialize(username, password, sender_name)
      # setup Request object
      uri = URI.parse("https://mobily.ws/")
      @http = Net::HTTP.new(uri.host, uri.port)
      @http.use_ssl = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      @username    = username
      @password    = password
      @sender_name = sender_name
    end

    def send(message:, numbers:[], **optional_params)
      receivers = numbers.join ","
      unicode_message = Mobilyws::encode(message)
      data = default_parameters(msg:unicode_message, numbers:receivers)

      request = Net::HTTP::Post.new("/api/msgSend.php")
      request.set_form_data(data)
      response = @http.request(request)
      SEND_MSG_RESPONSES[response.body]
    end

    def balance
      request  = Net::HTTP::Post.new("/api/balance.php")
      request.set_form_data(default_parameters)
      response = @http.request(request)
      response.body
    end

    def status
      request = Net::HTTP::Get.new("/api/sendStatus.php")
      response = @http.request(request)
      result = "Service Unavailable"
      result = "Service Available" if response.body == "1"
    end

    def default_parameters(**others)
      {
        mobile: @username,
        password: @password,
        sender: @sender_name,
        applicationType: 24
      }.merge(others)
    end

  end
  
end