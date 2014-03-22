require 'pg'
require './lib/expense.rb'
require './lib/category.rb'

DB = PG.connect({:dbname => 'expense_organizer'})

  def main_menu
    #puts "Welcome to our not-too-shabby expense tracker."
    puts "Press c to enter a Category"
    puts "Press e to enter an Expense"
    puts "Press cv to View All Categories"
    puts "Or press x to Exit"
    main_choice = gets.chomp

    case main_choice
      when 'c' then category_menu
      when 'cv' then category_view
      when 'e' then expense_menu
      when 'x' then puts "goodbye"
      else puts "Invalid option - please try again!"
          system "clear"
        main_menu
    end
  end


  def category_menu #this is a menu option
    puts "Create a Category"
    puts "Enter the Category Name:"
    #system "clear"
    category_name = gets.chomp

    Category.create({:description => category_name})
    puts "\nYour Category '#{category_name}' has been created!\n"
    puts "To create another category enter 'c', to return to the main menu enter 'm', to exit enter 'x'"
    user_input = gets.chomp

    case user_input
      when 'c' then category_menu
      when 'm' then main_menu
      when 'x' then puts "Goodbye!"
      else puts "Invalid option - please try again!"
        sleep(1)
        category_menu
    end
  end

  def list_categories
    Category.all.each do |cat|
      puts "#{cat.id} #{cat.description}\n"
    end
  end

  def category_view #this is a menu option
    puts "Here is a list of all your categories:"
    list_categories
    puts "To add another category, please enter 'c'"
    puts "To return to the main menu, enter 'm'"
    puts "To exit, enter 'x'"
    user_input = gets.chomp

    case user_input
      when 'c' then category_menu
      when 'm' then main_menu
      when 'x' then puts "Goodbye!"
      else puts "Invalid option - please try again!"
        sleep(1)
        category_view
    end
  end

  def expense_menu #this is a menu option
    puts "Enter an Expense"
    puts "Enter the description of the expense:"
    expense_description = gets.chomp
    puts "Enter the amount of the expense in the following format (5.00):"
    expense_amount = gets.chomp
    puts "Enter the Date of Purchase in the following format (2012-03-21):"
    expense_date = gets.chomp

    list_categories
    puts "Please enter the primary category ID number for this expense"
    category_id = gets.chomp
    puts "If you would like to add another category for this expense press 'y'."
    puts "Otherwise press 'n'."
    user_input = gets.chomp
    case user_input
      when 'y' then addl_categories
      else
        puts "If you need to create a new category for this expense, please enter 'cat'"
        puts "To return to the main menu please press 'm'"
        puts "To exit please enter 'x'"
        user_input = gets.chomp
    end

    case user_input
      when 'c' then category_menu
      when 'y' then category_menu
      when 'cat' then category_menu
      when 'm' then main_menu
      when 'x' then exit
      else puts "Please enter a valid option"
        sleep(1)
        expense_menu
    end


    def addl_categories
      puts "Please enter the secondary category ID number for this expense"

      list_categories
      puts "Please enter the primary category ID number for this expense"
      category_id = gets.chomp
      puts "If you would like to add another category for this expense press 'y'."
      puts "Otherwise press 'n'."
      user_input = gets.chomp
      case user_input
        when 'y' then addl_categories
        else
          puts "If you need to create a new category for this expense, please enter 'cat'"
          puts "To return to the main menu please press 'm'"
          puts "To exit please enter 'x'"
          user_input = gets.chomp
      end
    end

    #THIS HAS BEEN SEPARATED FROM THE FLOCK!!!
    # Expense.create({:description => expense_description, :amount => expense_amount, :date => expense_date, :category_id => category_id})
    # puts "'#{expense_description}' has been successfully added into your Expense Organizer!"
    # puts "If you would like to add another expense, enter 'e', to return to the main menu enter 'm', or enter 'x' to exit"
    # user_input = gets.chomp

    # case user_input
    #   when 'e' then expense_menu
    #   when 'm' then main_menu
    #   when 'x' then puts "Bye!"
    #   else puts "Please enter a valid option!"
    #     sleep(1)
    #     main_menu
    # end
  end

  main_menu
