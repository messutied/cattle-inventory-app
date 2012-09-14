require 'test_helper'

class GestionsControllerTest < ActionController::TestCase
  setup do
    @gestion = gestions(:one)
    @admin = users(:admin)
    session[:user_id] = @admin.id
  end
  
  def teardown
    session[:user_id] = nil
  end

  test "should create past gestion" do 
    post "crear_anterior", :gestion => "2012-7"
    assert_response 302
  end
end