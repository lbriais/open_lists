require 'test_helper'

module OpenLists
  class DomainListsControllerTest < ActionController::TestCase
    setup do
      @domain_list = domain_lists(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:domain_lists)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create domain_list" do
      assert_difference('DomainList.count') do
        post :create, domain_list: {  }
      end
  
      assert_redirected_to domain_list_path(assigns(:domain_list))
    end
  
    test "should show domain_list" do
      get :show, id: @domain_list
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @domain_list
      assert_response :success
    end
  
    test "should update domain_list" do
      put :update, id: @domain_list, domain_list: {  }
      assert_redirected_to domain_list_path(assigns(:domain_list))
    end
  
    test "should destroy domain_list" do
      assert_difference('DomainList.count', -1) do
        delete :destroy, id: @domain_list
      end
  
      assert_redirected_to domain_lists_path
    end
  end
end
