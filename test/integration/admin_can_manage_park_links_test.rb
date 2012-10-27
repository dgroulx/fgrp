require 'test_helper'

class AdminCanManageParkLinksTest < ActionDispatch::IntegrationTest
  fixtures :users, :parks, :park_links

  def setup 
    @admin = users(:admin)
    @park = parks(:aberdeen)
    sign_in(@admin.email, "password")
  end

  test 'admin can add new park links' do
    visit park_path(@park) 
  end

  test 'admin can edit park links' do
    
  end

  test 'admin can delete park links' do

  end
end
