require 'test_helper'

class SrpRequestsControllerTest < ActionController::TestCase
  setup do
    @srp_request = srp_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:srp_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create srp_request" do
    assert_difference('SrpRequest.count') do
      post :create, srp_request: { SRP_amount: @srp_request.SRP_amount, link: @srp_request.link, notes_admin: @srp_request.notes_admin, payment_id: @srp_request.payment_id, ship: @srp_request.ship, status: @srp_request.status, user_id: @srp_request.user_id, user_notes: @srp_request.user_notes }
    end

    assert_redirected_to srp_request_path(assigns(:srp_request))
  end

  test "should show srp_request" do
    get :show, id: @srp_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @srp_request
    assert_response :success
  end

  test "should update srp_request" do
    patch :update, id: @srp_request, srp_request: { SRP_amount: @srp_request.SRP_amount, link: @srp_request.link, notes_admin: @srp_request.notes_admin, payment_id: @srp_request.payment_id, ship: @srp_request.ship, status: @srp_request.status, user_id: @srp_request.user_id, user_notes: @srp_request.user_notes }
    assert_redirected_to srp_request_path(assigns(:srp_request))
  end

  test "should destroy srp_request" do
    assert_difference('SrpRequest.count', -1) do
      delete :destroy, id: @srp_request
    end

    assert_redirected_to srp_requests_path
  end
end
