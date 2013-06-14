require 'spec_helper'

describe 'User' do

  context 'signing up' do
    let(:user) { build(:user) }
    before do
      visit root_path

      fill_in 'user_first_name', with: user.first_name
      fill_in 'user_last_name', with: user.last_name
      fill_in 'user_username', with: user.username
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation
    end

    context 'with valid information' do
      describe 'when all inputs are filled in' do
        it 'will create a new account', js: true do
          expect {
            click_button 'Sign Up'
            sleep 0.2
            visit user_path(User.last)
            }.to change(User, :count).by(1)
          end
        end
      end

      context 'with invalid' do
        describe 'password confirmation' do
          it 'will return errors' do
            fill_in 'user_password_confirmation', with: 'yeah'
            click_button 'Sign Up'

            expect(page).to have_content "Password doesn't match confirmation"
          end
        end

        describe 'email' do
          it 'will return errors' do
            fill_in 'user_email', with: 'yeah'
            click_button 'Sign Up'

            expect(page).to have_content 'Email is invalid'
          end

        end
      end

      context 'without any information' do
        it 'will return errors' do
          visit current_path
          click_button 'Sign Up'

          expect(page).to have_content 'Email is invalid' && "Password can't be blank"
        end
      end
    end

    context 'logging in' do
      let(:user) { create(:user) }
      before do
        visit root_path
        fill_in 'username', with: user.username
        fill_in 'password', with: user.password
        click_button 'Login!'
      end

      context 'with valid info' do
        describe 'fields filled in' do
          it 'will login user', js: true do
            sleep 0.1
            expect(current_path).to eq(user_path(user))
          end
        end
      end

      context 'with invalid' do 
        describe 'username' do
          it 'will return errors' do
            fill_in 'username', with: 'nobody'
            click_button 'Login!'
            expect(page).to have_content 'Invalid username or password'
          end
        end
      end   
    end
  end
