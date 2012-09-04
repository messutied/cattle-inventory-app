require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)
    session[:user_id] = @admin.id
  end


end
