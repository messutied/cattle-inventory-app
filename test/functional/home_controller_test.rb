require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup do
    @users = User.all
    @admin = users(:admin)
    session[:user_id] = @admin.id
  end

  def teardown
    session[:user_id] = nil
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
