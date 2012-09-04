require 'test_helper'

class MovimientosControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)
    session[:user_id] = @admin.id
  end
  
  def teardown
    session[:user_id] = nil
  end

  

end
