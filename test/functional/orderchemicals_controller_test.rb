require 'test_helper'

class OrderchemicalsControllerTest < ActionController::TestCase
  setup do
    @orderchemical = orderchemicals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orderchemicals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orderchemical" do
    assert_difference('Orderchemical.count') do
      post :create, :orderchemical => @orderchemical.attributes
    end

    assert_redirected_to orderchemical_path(assigns(:orderchemical))
  end

  test "should show orderchemical" do
    get :show, :id => @orderchemical.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @orderchemical.to_param
    assert_response :success
  end

  test "should update orderchemical" do
    put :update, :id => @orderchemical.to_param, :orderchemical => @orderchemical.attributes
    assert_redirected_to orderchemical_path(assigns(:orderchemical))
  end

  test "should destroy orderchemical" do
    assert_difference('Orderchemical.count', -1) do
      delete :destroy, :id => @orderchemical.to_param
    end

    assert_redirected_to orderchemicals_path
  end
end
