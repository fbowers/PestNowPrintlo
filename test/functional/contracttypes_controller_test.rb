require 'test_helper'

class ContracttypesControllerTest < ActionController::TestCase
  setup do
    @contracttype = contracttypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contracttypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contracttype" do
    assert_difference('Contracttype.count') do
      post :create, :contracttype => @contracttype.attributes
    end

    assert_redirected_to contracttype_path(assigns(:contracttype))
  end

  test "should show contracttype" do
    get :show, :id => @contracttype.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @contracttype.to_param
    assert_response :success
  end

  test "should update contracttype" do
    put :update, :id => @contracttype.to_param, :contracttype => @contracttype.attributes
    assert_redirected_to contracttype_path(assigns(:contracttype))
  end

  test "should destroy contracttype" do
    assert_difference('Contracttype.count', -1) do
      delete :destroy, :id => @contracttype.to_param
    end

    assert_redirected_to contracttypes_path
  end
end
