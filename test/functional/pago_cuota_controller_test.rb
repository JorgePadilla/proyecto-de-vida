require 'test_helper'

class PagoCuotaControllerTest < ActionController::TestCase
  setup do
    @pago_cuotum = pago_cuota(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pago_cuota)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pago_cuotum" do
    assert_difference('PagoCuotum.count') do
      post :create, pago_cuotum: { cuota_id: @pago_cuotum.cuota_id, fecha: @pago_cuotum.fecha, monto: @pago_cuotum.monto, numero_deposito: @pago_cuotum.numero_deposito, revisado: @pago_cuotum.revisado }
    end

    assert_redirected_to pago_cuotum_path(assigns(:pago_cuotum))
  end

  test "should show pago_cuotum" do
    get :show, id: @pago_cuotum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pago_cuotum
    assert_response :success
  end

  test "should update pago_cuotum" do
    put :update, id: @pago_cuotum, pago_cuotum: { cuota_id: @pago_cuotum.cuota_id, fecha: @pago_cuotum.fecha, monto: @pago_cuotum.monto, numero_deposito: @pago_cuotum.numero_deposito, revisado: @pago_cuotum.revisado }
    assert_redirected_to pago_cuotum_path(assigns(:pago_cuotum))
  end

  test "should destroy pago_cuotum" do
    assert_difference('PagoCuotum.count', -1) do
      delete :destroy, id: @pago_cuotum
    end

    assert_redirected_to pago_cuota_path
  end
end
