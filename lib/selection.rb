class Selection
  def initialize(dish, qty)
    @dish = dish
    @qty = qty
  end 

  def dish
    @dish
  end

  def qty
    @qty
  end

  def view
    {dish: @dish.description, qty: @qty}
  end
end
