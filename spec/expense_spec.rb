require 'expense_organizer_spec_helper'

describe Expense do
  describe 'initialize' do
    it 'initializes an expense with a description, amount, and date.' do
      test_expense = Expense.new({:description => 'Coffee', :amount => 5.50, :date => '2014-03-21'})
      test_expense.should be_an_instance_of Expense
    end
  end

  describe '#save' do
    it 'collects all the expenses and saves them in an array' do
      test_expense = Expense.new({:description => 'Coffee', :amount => 5.50, :category_id => 3, :date => '2014-03-21'})
      test_expense.save
      Expense.all.length.should eq 1
      Expense.all[0].description.should eq 'Coffee'
    end
  end

  describe '.all' do
    it 'will start empty and returns a list of all saved expenses' do
      test_expense = Expense.new({:description => 'Coffee', :amount => 5.50, :date => '2014-03-21'})
      Expense.all.should eq []
    end
  end

  describe '#==' do
    it 'will eliminate any duplicate expenses if the description amount and date are the same' do
      test_expense1 = Expense.new({:description => 'Coffee', :amount => 5.50, :date => '2014-03-21'})
      test_expense2 = Expense.new({:description => 'Coffee', :amount => 5.50, :date => '2014-03-21'})
      test_expense1.should eq test_expense2
    end
  end

  describe '.create' do
    it 'will initialize and save at the same time.' do
      test_expense = Expense.create({:description => 'Coffee', :amount => 5.50, :category_id => 3, :date => '2014-03-21'})
      Expense.all.length.should eq 1
    end
  end

  describe '#delete' do
    it 'will destroy the chosen instance' do
      test_expense = Expense.create({:description => 'Peter', :amount => 100.00, :category_id => 2, :date => '10/4/2011'})
      test_expense.delete
      Expense.all.length.should eq 0
    end
  end

  describe '#modify' do
    it 'will modify the given instance' do
      test_expense = Expense.create({:description => 'Peter', :amount => 100.00, :category_id => 2, :date => '10/4/2011'})
      test_expense.modify({'description' => 'Monkey'})
      test_expense.description.should eq 'Monkey'
    end
  end

  describe '.total_expenses' do
    it 'will return the total amount spent' do
      test_expense = Expense.create({:description => 'Pizza', :amount => 12.00, :category_id => 1, :date => '10/4/2011'})
      test_expense2 = Expense.create({:description => 'Burgers', :amount => 8.00, :category_id => 2, :date => '10/4/2011'})
      test_expense3 = Expense.create({:description => 'Cake', :amount => 20.00, :category_id => 3, :date => '10/4/2011'})
      Expense.total_expenses.should eq 40.0
    end
  end

  describe '.total_category' do
    it 'will return the total amount for a category' do
      test_expense = Expense.create({:description => 'Pizza', :amount => 12.00, :category_id => 1, :date => '10/4/2011'})
      test_expense2 = Expense.create({:description => 'Burgers', :amount => 8.00, :category_id => 1, :date => '10/4/2011'})
      test_expense3 = Expense.create({:description => 'Cake', :amount => 20.00, :category_id => 3, :date => '10/4/2011'})
      Expense.total_category(1).should eq 20.0
    end
  end

  describe '.percent_category' do
    it 'will return a percentage spent in a category of total expenses' do
      test_expense = Expense.create({:description => 'Pizza', :amount => 12.00, :category_id => 1, :date => '10/4/2011'})
      test_expense2 = Expense.create({:description => 'Burgers', :amount => 8.00, :category_id => 1, :date => '10/4/2011'})
      test_expense3 = Expense.create({:description => 'Cake', :amount => 20.00, :category_id => 3, :date => '10/4/2011'})
      Expense.percent_category(1).should eq 0.5
    end
  end

  describe '.total_percent' do
    it 'will return percentages for all categories' do
      test_expense = Expense.create({:description => 'Pizza', :amount => 12.00, :category_id => 1, :date => '10/4/2011'})
      test_expense2 = Expense.create({:description => 'Burgers', :amount => 8.00, :category_id => 1, :date => '10/4/2011'})
      test_expense3 = Expense.create({:description => 'Cake', :amount => 20.00, :category_id => 3, :date => '10/4/2011'})
      Expense.total_percent.should eq [[1, 0.5], [3, 0.5]]
    end
  end
end
