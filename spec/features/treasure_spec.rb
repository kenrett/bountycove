require 'spec_helper'

describe 'Treasure' do
  
  context 'creating treasure' do
    let(:captain) { build(:captain) }
    let(:treasure) { build(:treasure) }

    before do
      visit root_path

      fill_in 'sign_up captain_first_name', with: captain.first_name
      fill_in '#big captain_last_name', with: captain.last_name
      fill_in '#big captain_username', with: captain.username
      fill_in '#big captain_email', with: captain.email
      fill_in '#big captain_password', with: captain.password
      fill_in '#big captain_password_confirmation', with: captain.password_confirmation
      click_button 'Sign Up'
    end

    context 'with valid information' do
      describe 'when all inputs are filled' do
        it 'will create a new treasure' do
          visit new_captain_treasure_path(captain)
          fill_in 'treasure_name', with: treasure.name
          fill_in 'treasure_description', with: treasure.description
          fill_in 'treasure_photo', with: treasure.photo
          fill_in 'treasure_price', with: treasure.price

          expect{
            click_button 'Create Treasure' 
            }.to change(Treasure, :count).by(1)
        end
      end      
    end
  end
end




