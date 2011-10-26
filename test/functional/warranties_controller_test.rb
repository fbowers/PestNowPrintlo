require 'test_helper'

class WarrantiesControllerTest < ActionController::TestCase
  setup do
    @warranty = warranties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warranties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warranty" do
    assert_difference('Warranty.count') do
      post :create, :warranty => @warranty.attributes
    end

    assert_redirected_to warranty_path(assigns(:warranty))
  end

  test "should show warranty" do
    get :show, :id => @warranty.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @warranty.to_param
    assert_response :success
  end

  test "should update warranty" do
    put :update, :id => @warranty.to_param, :warranty => @warranty.attributes
    assert_redirected_to warranty_path(assigns(:warranty))
  end

  test "should destroy warranty" do
    assert_difference('Warranty.count', -1) do
      delete :destroy, :id => @warranty.to_param
    end

    assert_redirected_to warranties_path
  end
end
