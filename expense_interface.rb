require 'pg'
require './lib/expense'

DB = PG.connect({:dbname => 'expense_organizer'})

  def welcome_menu
    puts "Welcome to our crappy expense tracker."
    puts "Press e to enter an expense"

    main_choice = gets.chomp
      if main_choice == 'e'
        enter_menu
      elsif main_choice == 'x'
        exit
      else
        welcome_menu
      end

      def enter_menu
        #sorry not started
      end
  end
