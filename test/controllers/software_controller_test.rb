require 'test_helper'

class SoftwareControllerTest < ActionDispatch::IntegrationTest
  setup do
    @software = software(:one)
  end

  test "should get index" do
    get software_index_url
    assert_response :success
  end

  test "should get new" do
    get new_software_url
    assert_response :success
  end

  test "should create software" do
    assert_difference('Software.count') do
      post software_index_url, params: { software: {  } }
    end

    assert_redirected_to software_url(Software.last)
  end

  test "should show software" do
    get software_url(@software)
    assert_response :success
  end

  test "should get edit" do
    get edit_software_url(@software)
    assert_response :success
  end

  test "should update software" do
    patch software_url(@software), params: { software: {  } }
    assert_redirected_to software_url(@software)
  end

  test "should destroy software" do
    assert_difference('Software.count', -1) do
      delete software_url(@software)
    end

    assert_redirected_to software_index_url
  end
end