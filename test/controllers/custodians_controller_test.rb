require 'test_helper'

class CustodiansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @custodian = custodians(:one)
  end

  test "should get index" do
    get custodians_url
    assert_response :success
  end

  test "should get new" do
    get new_custodian_url
    assert_response :success
  end

  test "should create custodian" do
    assert_difference('Custodian.count') do
      post custodians_url, params: { custodian: {  } }
    end

    assert_redirected_to custodian_url(Custodian.last)
  end

  test "should show custodian" do
    get custodian_url(@custodian)
    assert_response :success
  end

  test "should get edit" do
    get edit_custodian_url(@custodian)
    assert_response :success
  end

  test "should update custodian" do
    patch custodian_url(@custodian), params: { custodian: {  } }
    assert_redirected_to custodian_url(@custodian)
  end

  test "should destroy custodian" do
    assert_difference('Custodian.count', -1) do
      delete custodian_url(@custodian)
    end

    assert_redirected_to custodians_url
  end
end
