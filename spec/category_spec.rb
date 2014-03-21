require 'expense_organizer_spec_helper'

describe Category do
  describe 'initialize' do
    it 'initializes an Category with a description, amount, and date.' do
      test_category = Category.new({:description => 'Food'})
      test_category.should be_an_instance_of Category
    end
  end

  describe '#save' do
    it 'collects all the categories and saves them in an array' do
      test_category = Category.new({:description => 'Food'})
      test_category.save
      Category.all.length.should eq 1
      Category.all[0].description.should eq 'Food'
    end
  end

  describe '.all' do
    it 'will start empty and returns a list of all saved categories' do
      test_category = Category.new({:description => 'Food'})
      Category.all.should eq []
    end
  end

  describe '#==' do
    it 'will eliminate any duplicate categories if the description amount and date are the same' do
      test_category1 = Category.new({:description => 'Food'})
      test_category2 = Category.new({:description => 'Food'})
      test_category1.should eq test_category2
    end
  end

  describe '.create' do
    it 'will initialize and save at the same time.' do
      test_category = Category.create({:description => 'Food'})
      Category.all.length.should eq 1
    end
  end

  describe '#delete' do
    it 'will destroy the chosen instance' do
      test_category = Category.create({:description => 'Food'})
      test_category.delete
      Category.all.length.should eq 0
    end
  end

  describe '#modify' do
    it 'will modify the given instance' do
      test_category = Category.create({:description => 'Food'})
      test_category.modify({'description' => 'Monkeys'})
      test_category.description.should eq 'Monkeys'
    end
  end
end
