require "test_helper"

class ApiTest < Minitest::Test
  def setup
    # TODO should use stub
    # Add your credintials before test
    @username    = ENV["USERNAME"]
    @password    = ENV["PASSWORD"]
    @sender_name = ENV["SENDER_NAME"]
    @api = ::Mobilyws::API.new(@username, @password , @sender_name)
  end

  def test_initializer_should_accept_parameters_and_assign_them
    assert_equal @api.username, @username
    assert_equal @api.password, @password
    assert_equal @api.sender_name, @sender_name
  end

  # def test_send_message_with_all_paramete_return_1
  #   assert_equal ::Mobilyws::SEND_MSG_RESPONSES["1"], @api.send(message: "تجربة ارسال", numbers: ["966505*******"])
  # end
  
  def test_status_return_availbale
    assert_equal "Service Available", @api.status
  end

end