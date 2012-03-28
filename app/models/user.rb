class User
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email
  
  def self.authenticate(email)
    mailchimp = Gibbon.new('e9bfe9fb82eeba0fd75c7e012e33f859-us4')
    lists = ["18ab2f9e6d", "c6bc1cdbaf"]
    lists.each do |list|
      user_info = mailchimp.listMemberInfo :id => list, :email_address => email
      return self.new(:email => email) if user_info['success'] == 1
    end
    return nil
  end

  def initialize(params = {})
    self.email = params[:email]
  end

  def persisted?
    false
  end
end
