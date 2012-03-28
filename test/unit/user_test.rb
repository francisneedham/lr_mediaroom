require 'test_helper'
require 'minitest/autorun'

class UserTest < ActiveSupport::TestCase
  
  def test_new_user
    user = User.new(:email => 'test@email.com')
    assert_equal user.email, 'test@email.com'
  end

  def test_first_list_succesful_authentication
    user = User.authenticate('subscribed_to_first_list@email.com')
    assert user
    assert_equal user.email, 'subscribed_to_first_list@email.com'
  end

  def test_second_list_succesful_authentication
    user = User.authenticate('subscribed_to_second_list@email.com')
    assert user
    assert_equal user.email, 'subscribed_to_second_list@email.com'
  end

  def test_failed_authentication
    user = User.authenticate('not_subscribed@email.com')
    refute user
  end

end
