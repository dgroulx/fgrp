require 'test_helper'

class AdminCanManageFactsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:admin)
    sign_in(@admin.email, "password")
  end

  test 'admin can create facts' do
    assert_difference('Fact.count', 1) do
      visit admin_facts_path
      click_link "New Fact"
      fill_in "Question", with: "Smallest City Park"
      fill_in "Answer", with: "Sundial Park, 0.005 acers"
      click_button "Create Fact"
      assert page.has_content?("Smallest City Park")
      assert page.has_content?("Sundial Park, 0.005 acers")
    end
  end

  test 'admin can update facts' do
    @fact = facts(:largest_city_park)
    visit admin_facts_path
    within(:xpath, %Q{//td[text()="#{@fact.question}"]/parent::tr}) do
      click_link "Edit"
    end
    fill_in "Answer", with: "42"
    click_button "Update Fact"
    assert page.has_content?("42"), "Fact was not updated"
  end

  test 'admin can delete facts' do
    @fact = facts(:largest_city_park)
    visit admin_facts_path
    assert_difference('Fact.count', -1) do
      within(:xpath, %Q{//td[text()="#{@fact.question}"]/parent::tr}) do
        click_link "Delete"
      end
    end

    assert_false page.has_content?(@fact.question) 

  end
end
