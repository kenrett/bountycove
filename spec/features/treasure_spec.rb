require 'spec_helper'

describe 'User Profile' do
  context 'when signing in' do
   it 'will redirect to user profile page' do
    captain = FactoryGirl.create(:captain, :first_name => "Adam", :username => 'acsart')
    visit '/captains/acsart/'
    expect(page).to have_selector("p", :text => "Adam")
    end
  end

  context 'when on profile page' do
    it 'will have option to add pirate, add loot, add event and create adventure' do
      captain = FactoryGirl.create(:captain, :username => 'acsart')
      visit '/captains/acsart/'
      expect(page).to have_link("Add Pirate")
      expect(page).to have_link("Add Loot")
      expect(page).to have_link("Create Adventure")
      expect(page).to have_link("Add Event")
    end
  end
  
  context 'when on profile page' do
    it 'will redirect to add treasure when click add loot' do
      captain = FactoryGirl.create(:captain, :username => 'acsart')
      visit '/'
      fill_in 'username', with: captain.username
      fill_in 'password', with: captain.password
      click_button 'Login!' 
      visit '/captains/acsart/treasures'
      expect(page).to have_selector("div.create_treasure_form")
      expect(page).to have_selector("form")
      expect(page).to have_selector("input")
    end
  end
end




