require 'test_helper'

class ServicecodesControllerTest < ActionController::TestCase
  test "should get ServiceCodeId:integer" do
    get :ServiceCodeId:integer
    assert_response :success
  end

end
