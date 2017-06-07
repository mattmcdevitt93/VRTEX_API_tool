require 'test_helper'

class BlacklistsControllerTest < ActionController::TestCase
  setup do
    @blacklist = blacklists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blacklists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blacklist" do
    assert_difference('Blacklist.count') do
      post :create, blacklist: { Player_name: @blacklist.Player_name, character_type: @blacklist.character_type, reason: @blacklist.reason, reporter_id: @blacklist.reporter_id, tag: @blacklist.tag }
    end

    assert_redirected_to blacklist_path(assigns(:blacklist))
  end

  test "should show blacklist" do
    get :show, id: @blacklist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blacklist
    assert_response :success
  end

  test "should update blacklist" do
    patch :update, id: @blacklist, blacklist: { Player_name: @blacklist.Player_name, character_type: @blacklist.character_type, reason: @blacklist.reason, reporter_id: @blacklist.reporter_id, tag: @blacklist.tag }
    assert_redirected_to blacklist_path(assigns(:blacklist))
  end

  test "should destroy blacklist" do
    assert_difference('Blacklist.count', -1) do
      delete :destroy, id: @blacklist
    end

    assert_redirected_to blacklists_path
  end
end
