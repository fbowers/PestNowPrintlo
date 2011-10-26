require 'test_helper'

class OrderpadsControllerTest < ActionController::TestCase
  setup do
    @orderpad = orderpads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orderpads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orderpad" do
    assert_difference('Orderpad.count') do
      post :create, :orderpad => @orderpad.attributes
    end

    assert_redirected_to orderpad_path(assigns(:orderpad))
  end

  test "should show orderpad" do
    get :show, :id => @orderpad.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @orderpad.to_param
    assert_response :success
  end

  test "should update orderpad" do
    put :update, :id => @orderpad.to_param, :orderpad => @orderpad.attributes
    assert_redirected_to orderpad_path(assigns(:orderpad))
  end

  test "should destroy orderpad" do
    assert_difference('Orderpad.count', -1) do
      delete :destroy, :id => @orderpad.to_param
    end

    assert_redirected_to orderpads_path
  end
end
