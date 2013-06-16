require 'spec_helper'

describe 'Captain' do
  context 'when created' do
    describe 'with required valid inputs' do
      it 'will create user' do
        user = Captain.create( first_name: 'Dexter',
                            last_name: 'Vu',
                            email: 'dex@dex.com',
                            username: 'dextervu',
                            password: 'password')

        expect(user.valid?).to be_true
      end
    end

    describe 'with duplicate username' do
      it 'will not create user' do
       Captain.create(  first_name: 'Dexter',
                      last_name: 'Vu',
                      email: 'dex@dex.com',
                      username: 'dextervu',
                      password: 'password')

        user2 = Captain.create(  first_name: 'Dexter',
                              last_name: 'Vu',
                              email: 'dex@dex.com',
                              username: 'dextervu',
                              password: 'password')

        expect(user2.invalid?).to be_true
      end
    end

    describe 'with invalid email address' do
      it 'will not create user' do
        user = Captain.create( first_name: 'Dexter',
                            last_name: 'Vu',
                            email: 'd',
                            username: 'dextervu',
                            password: 'password')

        expect(user.invalid?).to be_true
      end
    end

    describe 'without any inputs' do
      it 'will not create user' do
        user = Captain.create( first_name: '',
                            last_name: '',
                            email: '',
                            username: '',
                            password: '')

        expect(user.invalid?).to be_true
      end
    end
  end
end

describe 'Pirate' do
  context 'when created' do
    describe 'with required valid inputs' do
      it 'will create user' do
        user = Pirate.create( first_name: 'Dexter',
                            last_name: 'Vu',
                            email: 'dex@dex.com',
                            username: 'dextervu',
                            password: 'password')

        expect(user.valid?).to be_true
      end
    end  

    describe 'with duplicate username' do
      it 'will not create user' do
       Pirate.create(  first_name: 'Ken',
                      last_name: 'Kenny',
                      email: 'kenny@kenster.com',
                      username: 'kennyboy',
                      password: 'password')

        user2 = Pirate.create(  first_name: 'Ken',
                              last_name: 'Kenny',
                              email: 'kenny@kenster.com',
                              username: 'kennyboy',
                              password: 'password')

        expect(user2.invalid?).to be_true
      end
    end

    describe 'with no email address' do
      it 'will create user' do
        user = Pirate.create( first_name: 'Ken',
                            last_name: 'Kenny',
                            email: '',
                            username: 'kennyboy',
                            password: 'password')

        expect(user.valid?).to be_true
      end
    end    

    describe 'with invalid email address' do
      it 'will create user' do
        user = Pirate.create( first_name: 'Ken',
                            last_name: 'Kenny',
                            email: 'd',
                            username: 'kennyboy',
                            password: 'password')

        expect(user.invalid?).to be_true
      end
    end

    describe 'without any inputs' do
      it 'will not create user' do
        user = Pirate.create( first_name: '',
                            last_name: '',
                            email: '',
                            username: '',
                            password: '')

        expect(user.invalid?).to be_true
      end
    end
  end
end
