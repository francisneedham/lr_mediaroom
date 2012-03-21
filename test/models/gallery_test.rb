require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Gallery Model" do
  it 'can construct a new instance' do
    @gallery = Gallery.new
    refute_nil @gallery
  end
end
