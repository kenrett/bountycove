require 'spec_helper'

describe 'Task' do
  let(:captain) { build(:captain) }
  let(:task) { build(:task) }

  before do
    visit root_path

    fill_in 'captain_first_name', with: captain.first_name
    fill_in 'captain_last_name', with: captain.last_name
    fill_in 'captain_username', with: captain.username
    fill_in 'captain_email', with: captain.email
    fill_in 'captain_password', with: captain.password
    fill_in 'captain_password_confirmation', with: captain.password_confirmation
    click_button 'Sign Up'
    visit new_captain_task_path(captain)
  end

  context 'with valid information' do
    describe 'when all inputs are filled in correctly' do
      pending
      # it 'will create a new task' do
      #   fill_in 'task_name', with: task.name
      #   fill_in 'task_description', with: task.description
      #   fill_in 'task_worth', with: task.worth
      #   click_button 'Create Task'
      #   expect(page.current_path).to eq captain_tasks_path(captain)
      # end
    end
  end

  context 'with invalid information:' do
    describe 'worth value is not an integer' do
      pending
      # it 'will return errors' do
      #   fill_in 'task_worth', with: 'yeah'
      #   click_button 'Create Task'

      #   expect(page).to have_content "Worth is not a number"
      # end
    end

    describe 'without any information' do
      pending
      # it 'will return errors' do
      #   click_button 'Create Task'

      #   expect(page).to have_content "Worth can't be blank" && "Worth is not a number" && "Name has already been taken" && "Description can't be blank"
      # end
    end
  end
end
