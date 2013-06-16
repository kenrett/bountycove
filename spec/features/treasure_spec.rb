require 'spec_helper'

describe 'User Profile', :js => true do
  context 'when signing in' do
   it 'will redirect to user profile page' do
    captain = FactoryGirl.create(:captain, :username => 'acsart')
    visit '/captains/acsart/'
    expect(page).to have_link("Add Loot")
    end
  end
end




