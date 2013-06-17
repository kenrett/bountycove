require 'spec_helper'

describe 'Treasure' do
  context 'when created' do
    describe 'with required valid inputs' do
      it 'will create treasure' do
        treasure = Treasure.create( name: 'gold coins',
                                    description: '50 gold coins',
                                    photo: 'www.pirate.com/images',
                                    price: '10')

        expect(treasure.valid?).to be_true
      end
    end

    it 'should belong_to captain' do
        t = Treasure.reflect_on_association(:captain)
        t.macro.should == :belongs_to
    end


    it 'should belong_to pirate' do
        t = Treasure.reflect_on_association(:pirate)
        t.macro.should == :belongs_to
    end

    it 'should default to status 1' do
      t = Treasure.create(name: 'gold coins',
                          description: '50 gold coins',
                          photo: 'www.pirate.com/images',
                          price: '10')
      t.status.should == 1
    end

    describe 'without price' do
      it 'will not create treasure' do
        treasure = Treasure.create( name: 'gold',
                                    description: '50 gold coins',
                                    photo: 'www.pirate.com/images')

        expect(treasure.invalid?).to be_true
      end
    end

    describe 'without name' do
      it 'will not create treasure' do
        treasure = Treasure.create( description: '50 gold coins',
                                    photo: 'www.pirate.com/images',
                                    price: '10')

        expect(treasure.invalid?).to be_true
      end
    end

    describe 'without description' do
      it 'will not create treasure' do
        treasure = Treasure.create( name: 'gold',
                                    photo: 'www.pirate.com/images',
                                    price: '10')

        expect(treasure.invalid?).to be_true
      end
    end
  end
end
