require 'test_helper'

class CustodianAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @custodian_account = custodian_accounts(:one)
  end

  test "should get index" do
    get custodian_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_custodian_account_url
    assert_response :success
  end

  test "should create custodian_account" do
    assert_difference('CustodianAccount.count') do
      post custodian_accounts_url, params: { custodian_account: {  } }
    end

    assert_redirected_to custodian_account_url(CustodianAccount.last)
  end

  test "should show custodian_account" do
    get custodian_account_url(@custodian_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_custodian_account_url(@custodian_account)
    assert_response :success
  end

  test "should update custodian_account" do
    patch custodian_account_url(@custodian_account), params: { custodian_account: {  } }
    assert_redirected_to custodian_account_url(@custodian_account)
  end

  test "should destroy custodian_account" do
    assert_difference('CustodianAccount.count', -1) do
      delete custodian_account_url(@custodian_account)
    end

    assert_redirected_to custodian_accounts_url
  end
end
