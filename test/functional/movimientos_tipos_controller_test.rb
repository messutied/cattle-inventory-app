require 'test_helper'

class MovimientosTiposControllerTest < ActionController::TestCase
  setup do
    @movimientos_tipo = movimientos_tipos(:one)
    @admin = users(:admin)
    session[:user_id] = @admin.id
  end
  
  def teardown
    session[:user_id] = nil
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movimientos_tipos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movimientos_tipo" do
    assert_difference('MovimientosTipo.count') do
      post :create, :movimientos_tipo => @movimientos_tipo.attributes
    end

    assert_redirected_to movimientos_tipo_path(assigns(:movimientos_tipo))
  end

  test "should show movimientos_tipo" do
    get :show, :id => @movimientos_tipo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @movimientos_tipo.to_param
    assert_response :success
  end

  test "should update movimientos_tipo" do
    put :update, :id => @movimientos_tipo.to_param, :movimientos_tipo => @movimientos_tipo.attributes
    assert_redirected_to movimientos_tipo_path(assigns(:movimientos_tipo))
  end

  test "should destroy movimientos_tipo" do
    assert_difference('MovimientosTipo.count', -1) do
      delete :destroy, :id => @movimientos_tipo.to_param
    end

    assert_redirected_to movimientos_tipos_path
  end
end
