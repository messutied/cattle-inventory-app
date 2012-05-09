require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get inventario_mensual" do
    get :inventario_mensual
    assert_response :success
  end

end
