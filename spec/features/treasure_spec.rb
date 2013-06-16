require 'spec_helper'


describe 'Treasure' do
  context 'adding loot' do
    it 'will create a new treasure' do
    before do
      captain = FactoryGirl.create(:captain, :username => 'acsart')
      visit '/'
      fill_in 'username', with: captain.username
      fill_in 'password', with: captain.password
      click_button 'Login!' 
    end
      visit '/captains/acsart/treasures'
      fill_in 'name', with: 'test treasure'
      fill_in 'description', with: 'test description'
      fill_in 'photo', with: 'test photo'
      fill_in 'price', with: '5'
      click_button 'Create Treasure'
      expect(Treasure.all.count).to change_by(1)
      end      
    end
  end

  # context 'when on profile page' do
  #   it 'will have option to add pirate, add loot, add event and create adventure' do
  #     visit '/captains/acsart/'
  #     expect(page).to have_link("Add Pirate")
  #     expect(page).to have_link("Add Loot")
  #     expect(page).to have_link("Create Adventure")
  #     expect(page).to have_link("Add Event")
  #   end
  # end
  
  # context 'when on profile page' do
  #   it 'will redirect to add treasure when click add loot' do
  #     captain = FactoryGirl.create(:captain, :username => 'acsart')
  #     visit '/'
  #     expect(page).to have_selector("div.create_treasure_form")
  #     expect(page).to have_selector("form")
  #     expect(page).to have_selector("input")






