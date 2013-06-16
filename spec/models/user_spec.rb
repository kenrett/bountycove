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

      it 'should have_many pirates' do
        t = Captain.reflect_on_association(:pirates)
        t.macro.should == :has_many
      end

      it 'should have_many treasures' do
        t = Captain.reflect_on_association(:treasures)
        t.macro.should == :has_many
      end

      it 'should have tasks' do
        t = Captain.reflect_on_association(:tasks)
        t.macro.should == :has_many
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

    describe 'with no first_name' do
      it 'will not create user' do
        user = Captain.create( first_name: '',
                               last_name: 'Vu',
                               email: 'dex@dex.com',
                               username: 'dextervu',
                               password: 'password')

        expect(user.invalid?).to be_true
      end
    end

    describe 'with no last_name' do
      it 'will not create user' do
        user = Captain.create( first_name: 'Dexter',
                               last_name: '',
                               email: 'dex@dex.com',
                               username: 'dextervu',
                               password: 'password')

        expect(user.invalid?).to be_true
      end
    end

    describe 'with no email address' do
      it 'will not create user' do
        user = Captain.create( first_name: 'Dexter',
                               last_name: 'Vu',
                               email: '',
                               username: 'dextervu',
                               password: 'password')

        expect(user.invalid?).to be_true
      end
    end

    describe 'with no username' do
      it 'will not create user' do
        user = Captain.create( first_name: 'Dexter',
                               last_name: 'Vu',
                               email: 'dex@dex.com',
                               username: '',
                               password: 'password')

        expect(user.invalid?).to be_true
      end
    end

    describe 'with no password' do
      it 'will not create user' do
        user = Captain.create( first_name: 'Dexter',
                               last_name: 'Vu',
                               email: 'dex@dex.com',
                               username: 'dextervu',
                               password: '')

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
      user = Pirate.create(  first_name: 'Ken',
                      last_name: 'Kenny',
                      email: 'kenny@kenster.com',
                      username: 'kennyboy',
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

    describe 'when belongs to Captain' do
      it 'Pirate will be associated' do
        captain = Captain.create( first_name: 'Dexter',
                            last_name: 'Vu',
                            email: 'dex@dex.com',
                            username: 'dextervu',
                            password: 'password')

        pirate = Pirate.create( first_name: 'Ken',
                            last_name: 'Kenny',
                            email: 'kenny@kenster.com',
                            username: 'kennyboy',
                            password: 'password')
        
        captain.pirates << pirate

        expect(captain.id).to eq(pirate.captain_id)
      end
    end
  end
end
