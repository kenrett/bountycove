require 'spec_helper'

describe 'Task' do
  context 'when created' do

    describe 'with required valid inputs' do
      it 'will create task' do
        task = Task.create(name: 'Ken',
                           description: "Description",
                           worth: 150)

        expect(task.valid?).to be_true
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
