require 'test_helper'

class RusersControllerTest < ActionController::TestCase
  setup do
    @ruser = rusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ruser" do
    assert_difference('Ruser.count') do
      post :create, :ruser => @ruser.attributes
    end

    assert_redirected_to ruser_path(assigns(:ruser))
  end

  test "should show ruser" do
    get :show, :id => @ruser.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ruser.to_param
    assert_response :success
  end

  test "should update ruser" do
    put :update, :id => @ruser.to_param, :ruser => @ruser.attributes
    assert_redirected_to ruser_path(assigns(:ruser))
  end

  test "should destroy ruser" do
    assert_difference('Ruser.count', -1) do
      delete :destroy, :id => @ruser.to_param
    end

    assert_redirected_to rusers_path
  end
end
