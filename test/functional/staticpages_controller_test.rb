require 'test_helper'

class StaticpagesControllerTest < ActionController::TestCase
  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get service" do
    get :service
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

  test "should get whybuy" do
    get :whybuy
    assert_response :success
  end

  test "should get launch" do
    get :launch
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get howlaunch" do
    get :howlaunch
    assert_response :success
  end

  test "should get howbuy" do
    get :howbuy
    assert_response :success
  end

end
