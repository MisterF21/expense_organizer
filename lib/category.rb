class Category
  attr_reader :description, :id

  def initialize(attributes)
    @attributes = ['description', 'id']
    @description = attributes[:description]
    @id = attributes[:id]
  end

  def self.create(attributes)
    new_expense = self.new(attributes)
    new_expense.save
    new_expense
  end

  def self.all
    results = DB.exec("SELECT * FROM categories;")
    categories_array = []
    results.each do |result|
      description = result['description']
      id = result['id']
      categories_array << Category.new({:description => description, :id => id})
  end
    categories_array
  end

  def save
    result = DB.exec("INSERT INTO categories (description) VALUES ('#{@description}') RETURNING id;")
    @id = result.first['id']
  end

  def delete
    DB.exec("DELETE FROM categories WHERE id = #{id};")
  end

  def modify(new_attributes)
    new_attributes.each do |column_name, attribute|
      DB.exec("UPDATE categories SET #{column_name} = '#{attribute}' WHERE id = #{id};")
    end
    @attributes.each do |attribute|
      if new_attributes[attribute] != nil
        new_attribute = new_attributes[attribute]
        change_instance(attribute, new_attribute)
      end
    end
  end

  def change_instance(attribute, new_attribute)
    var_name = "@#{attribute}"
    self.instance_variable_set(var_name, new_attribute)
  end

  def ==(another_expense)
    self.description == another_expense.description
  end
end
