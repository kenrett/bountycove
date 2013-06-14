require 'spec_helper'

describe 'User' do
  context 'signing up' do
    before { visit root_path }

    context 'with valid information' do
      describe 'when all inputs are filled in' do
        it 'will create a new account' do
          pending
        end
      end
    end

    context 'with invalid information' do
      describe 'such as password' do
        it 'will return errors' do
          pending
        end

        describe 'such as email' do
          it 'will return errors' do
            pending
          end
        end
      end

      context 'without any information' do
        it 'will return errors' do
          pending
        end
      end
    end
  end
end
