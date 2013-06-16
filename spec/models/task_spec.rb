require 'spec_helper'

describe 'Task' do

  context 'when created' do

    it 'should belong to a captain' do
      t = Task.reflect_on_association(:captain)
      t.macro.should == :belongs_to
    end

    it 'should belong to a pirate' do
      t = Task.reflect_on_association(:pirate)
      t.macro.should == :belongs_to
    end

    it 'should default to status 1' do
      task = Task.create(name: 'Ken',
                           description: "Description",
                           worth: 150)
      task.status.should == 1
    end

    describe 'with required valid inputs' do
      it 'will create task' do
        task = Task.create(name: 'Ken',
                           description: "Description",
                           worth: 150)

        expect(task.valid?).to be_true
      end
    end

  context 'will not be created'  

    describe 'with incorrect input' do
      it 'of worth not being an integer' do
        task = Task.create(name: 'Ben',
                             description: "Description",
                             worth: 'car')

         expect(task.valid?).to be_false
      end

      it 'of name not being a string' do
        task = Task.create(name: '',
                             description: "Description",
                             worth: 12)
        expect(task.valid?).to be_false
      end

      it 'of description not being a string' do
        task = Task.create(name: 'Ben',
                             description: '',
                             worth: 12)

        expect(task.valid?).to be_false
      end
    end

    describe 'without any inputs' do
      it 'will not create task' do
        task = Task.create(name: '',
                           description: '',
                           worth: '')
        expect(task.invalid?).to be_true
      end
    end
  end
end
