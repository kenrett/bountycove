require 'spec_helper'

describe 'Treasure' do
  context 'adding treasure' do
    let(:user) { build(:user) }
    let(:treasure) { build(:treasure) }

    before do
      visit root_path

      
