class Dish
  def initialize(description, price)
    @description = description
    @price = price
  end

  def description
    @description
  end

  def price
    @price
  end

   def view
    {description: @description, price: @price}
  end
end
