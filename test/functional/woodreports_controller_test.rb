require 'test_helper'

class WoodreportsControllerTest < ActionController::TestCase
  setup do
    @woodreport = woodreports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:woodreports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create woodreport" do
    assert_difference('Woodreport.count') do
      post :create, :woodreport => @woodreport.attributes
    end

    assert_redirected_to woodreport_path(assigns(:woodreport))
  end

  test "should show woodreport" do
    get :show, :id => @woodreport.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @woodreport.to_param
    assert_response :success
  end

  test "should update woodreport" do
    put :update, :id => @woodreport.to_param, :woodreport => @woodreport.attributes
    assert_redirected_to woodreport_path(assigns(:woodreport))
  end

  test "should destroy woodreport" do
    assert_difference('Woodreport.count', -1) do
      delete :destroy, :id => @woodreport.to_param
    end

    assert_redirected_to woodreports_path
  end
end
