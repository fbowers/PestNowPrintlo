require 'test_helper'

class WdireportsControllerTest < ActionController::TestCase
  setup do
    @wdireport = wdireports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wdireports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wdireport" do
    assert_difference('Wdireport.count') do
      post :create, :wdireport => @wdireport.attributes
    end

    assert_redirected_to wdireport_path(assigns(:wdireport))
  end

  test "should show wdireport" do
    get :show, :id => @wdireport.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @wdireport.to_param
    assert_response :success
  end

  test "should update wdireport" do
    put :update, :id => @wdireport.to_param, :wdireport => @wdireport.attributes
    assert_redirected_to wdireport_path(assigns(:wdireport))
  end

  test "should destroy wdireport" do
    assert_difference('Wdireport.count', -1) do
      delete :destroy, :id => @wdireport.to_param
    end

    assert_redirected_to wdireports_path
  end
end
