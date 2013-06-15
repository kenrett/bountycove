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
    
    describe 'with duplicate name' do
      it 'will not create treasure' do
        Treasure.create( name: 'gold coins',
                         description: '50 gold coins',
                         photo: 'www.pirate.com/images',
                         price: '10')

        treasure_2 = Treasure.create( name: 'gold coins',
                                      description: '50 gold coins',
                                      photo: 'www.pirate.com/images',
                                      price: '10')

        expect(treasure_2.invalid?).to be_true
      end
    end

    describe 'with duplicate photo' do
      it 'will not create treasure' do
        Treasure.create( name: 'gold',
                         description: '50 gold coins',
                         photo: 'www.pirate.com/images',
                         price: '10')

        treasure_2 = Treasure.create( name: 'gold coins',
                                      description: '50 gold coins',
                                      photo: 'www.pirate.com/images',
                                      price: '10')

        expect(treasure_2.invalid?).to be_true
      end
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
