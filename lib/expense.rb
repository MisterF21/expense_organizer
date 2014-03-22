class Expense
  attr_reader :description, :amount, :date, :category_id, :id

  def initialize(attributes)
    @attributes = ['description', 'amount', 'date', 'category_id', 'id']
    @description = attributes[:description]
    @amount = attributes[:amount]
    @date = attributes[:date]
    @category_id = attributes[:category_id]
    @id = attributes[:id]
  end

  def self.create(attributes)
    new_expense = self.new(attributes)
    new_expense.save
    new_expense
  end

  def self.all
    results = DB.exec("SELECT * FROM expenses;")
    expenses_array = []
    results.each do |result|
      description = result['description']
      amount = result['amount'].to_f
      date = result['date']
      category_id = result['category_id']
      id = result['id']
      expenses_array << Expense.new({:description => description, :amount => amount, :date => date, :category_id => category_id, :id => id})
  end
    expenses_array
  end

  def self.total_percent
    category_ids = []
    results = []
    self.all.each do |item|
      category_ids << item.category_id
    end
    category_ids.uniq.each do |category_id|
      results << [category_id.to_i, self.percent_category(category_id)]
    end
    results
  end

  def self.percent_category(category_id)
    total_expenses = self.total_expenses
    category_expense = self.total_category(category_id)
    output = category_expense / total_expenses
  end

  def self.total_expenses
    result = DB.exec("SELECT sum(amount) FROM expenses;")
    result.first['sum'].to_f
  end

  def self.total_category(category_id)
    result = DB.exec("SELECT sum(amount) FROM expenses WHERE category_id = #{category_id};")
    result.first['sum'].to_f
  end

  def save
    result = DB.exec("INSERT INTO expenses (description, amount, date, category_id) VALUES ('#{@description}', '#{@amount}', '#{@date}', #{category_id}) RETURNING id;")
    @id = result.first['id']
  end

  def delete
    DB.exec("DELETE FROM expenses WHERE id = #{id};")
  end

  def modify(attributes)
    attributes.each do |column_name, attribute|
      DB.exec("UPDATE expenses SET #{column_name} = '#{attribute}' WHERE id = #{id};")
    end
    @attributes.each do |attribute|
      if attributes[attribute] != nil
        new_attribute = attributes[attribute]
        var_name = "@#{attribute}"
        self.instance_variable_set(var_name, new_attribute)
      end
    end
  end

  def ==(another_expense)
    self.description == another_expense.description &&
    self.amount == another_expense.amount &&
    self.date == another_expense.date &&
    self.category_id == another_expense.category_id &&
    self.id == another_expense.id
  end

  # def join_exp_cat
  #   results = DB.exec("SELECT category.* FROM expenses JOIN exp_cat ON (expenses.id = category.expenses_id) JOIN category ON (exp_cat.id = category_id) WHERE expenses.id = '#{@description}")
  # end

end
