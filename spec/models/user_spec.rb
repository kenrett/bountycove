require 'spec_helper'

describe 'User' do
  context 'when created' do
    describe 'with required valid inputs' do
      it 'will create user' do
        user = User.create(first_name: 'Dexter', last_name: 'Vu', username: 'dextervu', password: 'password')
        expect(user.valid?).to be_true
      end
    end
  end
end
