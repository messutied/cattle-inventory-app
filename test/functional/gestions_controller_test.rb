require 'test_helper'

class GestionsControllerTest < ActionController::TestCase
  setup do
    @gestion = gestions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gestions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gestion" do
    assert_difference('Gestion.count') do
      post :create, :gestion => @gestion.attributes
    end

    assert_redirected_to gestion_path(assigns(:gestion))
  end

  test "should show gestion" do
    get :show, :id => @gestion.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @gestion.to_param
    assert_response :success
  end

  test "should update gestion" do
    put :update, :id => @gestion.to_param, :gestion => @gestion.attributes
    assert_redirected_to gestion_path(assigns(:gestion))
  end

  test "should destroy gestion" do
    assert_difference('Gestion.count', -1) do
      delete :destroy, :id => @gestion.to_param
    end

    assert_redirected_to gestions_path
  end
end
