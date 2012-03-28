class User
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :email

  def initialize(params = {})
    self.email = params[:email]
  end

  def persisted?
    false
  end
end
