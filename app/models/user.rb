class User
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email

  LISTS = ["50dbfac20c"]
  MAILCHIMP_API_KEY = 'e9bfe9fb82eeba0fd75c7e012e33f859-us4'

  
  def self.authenticate(email)
    mailchimp = Gibbon.new(MAILCHIMP_API_KEY)
    LISTS.each do |list|
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
