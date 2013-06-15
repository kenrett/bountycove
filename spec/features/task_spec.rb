# require 'spec_helper'

# describe 'Task' do

#   context 'with valid information' do
#     describe 'when all inputs are filled in' do
#       it 'will create a new account' do
#         click_button 'Sign Up'
#         expect(page.current_path).to eq captain_path(Captain.last.username)
#       end
#     end
#   end

#   context 'with invalid' do
#     describe 'password confirmation' do
#       it 'will return errors' do
#         fill_in 'captain_password_confirmation', with: 'yeah'
#         click_button 'Sign Up'

#         expect(page).to have_content "Password doesn't match confirmation"
#       end
#     end

#     describe 'email' do
#       it 'will return errors' do
#         fill_in 'captain_email', with: 'yeah'
#         click_button 'Sign Up'

#         expect(page).to have_content 'Email is invalid'
#       end
#     end
#   end

#   context 'without any information' do
#     it 'will return errors' do
#       visit current_path
#       click_button 'Sign Up'

#       expect(page).to have_content 'Email is invalid' && "Password can't be blank"
#     end
#   end


#   context 'logging in' do
#     let(:captain) { create(:captain) }
#     before do
#       visit root_path
#       fill_in 'username', with: captain.username
#       fill_in 'password', with: captain.password
#       click_button 'Login!'
#     end

#     context 'with valid info' do
#       describe 'will login' do
#         it 'user' do
#           expect(page.current_path).to eq(captain_path(captain.username))
#         end
#       end
#     end
#   end

#   context 'with invalid' do 
#     before do
#       visit root_path
#       fill_in 'username', with: 'nothing'
#       fill_in 'password', with: 'nothing'
#     end

#     describe 'username' do
#       it 'will return errors' do
#         click_button 'Login!'
#         expect(page).to have_content 'Invalid username or password'
#       end
#     end

#     describe 'password' do
#       it 'will return errors' do
#         click_button 'Login!'
#         expect(page).to have_content 'Invalid username or password'
#       end
#     end
#   end
# end  


