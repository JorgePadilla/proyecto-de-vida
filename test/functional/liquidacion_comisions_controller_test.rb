require 'test_helper'

class LiquidacionComisionsControllerTest < ActionController::TestCase
  setup do
    @liquidacion_comision = liquidacion_comisions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:liquidacion_comisions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create liquidacion_comision" do
    assert_difference('LiquidacionComision.count') do
      post :create, liquidacion_comision: { empleado_id: @liquidacion_comision.empleado_id, fecha: @liquidacion_comision.fecha, monto: @liquidacion_comision.monto, rol: @liquidacion_comision.rol }
    end

    assert_redirected_to liquidacion_comision_path(assigns(:liquidacion_comision))
  end

  test "should show liquidacion_comision" do
    get :show, id: @liquidacion_comision
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @liquidacion_comision
    assert_response :success
  end

  test "should update liquidacion_comision" do
    put :update, id: @liquidacion_comision, liquidacion_comision: { empleado_id: @liquidacion_comision.empleado_id, fecha: @liquidacion_comision.fecha, monto: @liquidacion_comision.monto, rol: @liquidacion_comision.rol }
    assert_redirected_to liquidacion_comision_path(assigns(:liquidacion_comision))
  end

  test "should destroy liquidacion_comision" do
    assert_difference('LiquidacionComision.count', -1) do
      delete :destroy, id: @liquidacion_comision
    end

    assert_redirected_to liquidacion_comisions_path
  end
end
