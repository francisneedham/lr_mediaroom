require 'test_helper'
require 'minitest/autorun'

class UserTest < ActiveSupport::TestCase
  
  def test_email
    user = User.new(:email => 'test@email.it')
    assert_equal user.email, 'test@email.it'
  end
end
