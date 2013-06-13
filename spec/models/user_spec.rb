require 'spec_helper'

describe 'User' do
  context 'when created' do
    describe 'with required valid inputs' do
      it 'will create user' do
        user = User.create( first_name: 'Dexter',
                            last_name: 'Vu',
                            email: 'dex@dex.com',
                            username: 'dextervu',
                            password: 'password')
        expect(user.valid?).to be_true
      end
    end

    describe 'without any inputs' do
      it 'will not create user' do
        user = User.create( first_name: '',
                            last_name: '',
                            email: '',
                            username: '',
                            password: '')

        expect(user.invalid?).to be_true
      end
    end
  end
end
