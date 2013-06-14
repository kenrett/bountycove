require 'spec_helper'

describe 'Task' do
  context 'adding task' do
    let(:user) { build(:user) }
    let(:task) { build(:task) }

    before do
      visit root_path

      
