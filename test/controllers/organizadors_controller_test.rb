require 'test_helper'

class OrganizadorsControllerTest < ActionController::TestCase
  setup do
    @organizador = organizadors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organizadors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organizador" do
    assert_difference('Organizador.count') do
      post :create, organizador: { apellido_mat_org: @organizador.apellido_mat_org, apellido_pat_org: @organizador.apellido_pat_org, email_org: @organizador.email_org, fecha_nac_org: @organizador.fecha_nac_org, foto_org: @organizador.foto_org, nombre_org: @organizador.nombre_org, rut_org: @organizador.rut_org, sexo_org: @organizador.sexo_org }
    end

    assert_redirected_to organizador_path(assigns(:organizador))
  end

  test "should show organizador" do
    get :show, id: @organizador
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organizador
    assert_response :success
  end

  test "should update organizador" do
    patch :update, id: @organizador, organizador: { apellido_mat_org: @organizador.apellido_mat_org, apellido_pat_org: @organizador.apellido_pat_org, email_org: @organizador.email_org, fecha_nac_org: @organizador.fecha_nac_org, foto_org: @organizador.foto_org, nombre_org: @organizador.nombre_org, rut_org: @organizador.rut_org, sexo_org: @organizador.sexo_org }
    assert_redirected_to organizador_path(assigns(:organizador))
  end

  test "should destroy organizador" do
    assert_difference('Organizador.count', -1) do
      delete :destroy, id: @organizador
    end

    assert_redirected_to organizadors_path
  end
end
