require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  test "should get me" do
    get :me
    assert_response :success
  end

end
