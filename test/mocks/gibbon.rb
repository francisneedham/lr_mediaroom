class Gibbon
  LISTS = {
    "18ab2f9e6d" => ['subscribed_to_first_list@email.com'],
    "c6bc1cdbaf" => ['subscribed_to_second_list@email.com']
  }
  attr_accessor :list, :email_address

  def initialize(api_key)
    # do nothing
  end

  def listMemberInfo(params = {})
    success =  (LISTS[params[:id]].include? params[:email_address]) ? 1 : 0
    return { 'success' => success }
  end
end
