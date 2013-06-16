# require 'spec_helper'

# describe 'Treasure' do
#   before do
#     captain = FactoryGirl.create(:captain, :username => 'acsart')
#     @treasure = FactoryGirl.create(:treasure)
#     visit '/'
#     fill_in 'username', with: captain.username
#     fill_in 'password', with: captain.password
#     click_button 'Login!' 
#   end
#   context 'adding loot' do
#     it 'will create a new treasure' do
#       visit '/captains/acsart/treasures'
#       fill_in 'treasure_name', with: @treasure.name
#       fill_in 'treasure_description', with: @treasure.description
#       fill_in 'treasure_photo', with: @treasure.photo
#       fill_in 'treasure_price', with: @treasure.price
#       click_button 'Create Treasure'

#       expect{ }.to change(Treasure, :count).by(1)
      
#       end      
#     end
#   end




