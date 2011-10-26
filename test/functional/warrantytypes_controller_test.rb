require 'test_helper'

class WarrantytypesControllerTest < ActionController::TestCase
  setup do
    @warrantytype = warrantytypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warrantytypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warrantytype" do
    assert_difference('Warrantytype.count') do
      post :create, :warrantytype => @warrantytype.attributes
    end

    assert_redirected_to warrantytype_path(assigns(:warrantytype))
  end

  test "should show warrantytype" do
    get :show, :id => @warrantytype.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @warrantytype.to_param
    assert_response :success
  end

  test "should update warrantytype" do
    put :update, :id => @warrantytype.to_param, :warrantytype => @warrantytype.attributes
    assert_redirected_to warrantytype_path(assigns(:warrantytype))
  end

  test "should destroy warrantytype" do
    assert_difference('Warrantytype.count', -1) do
      delete :destroy, :id => @warrantytype.to_param
    end

    assert_redirected_to warrantytypes_path
  end
end
