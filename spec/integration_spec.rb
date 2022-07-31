require 'customer'

RSpec.describe Customer do
  xit "shows menu" do
    spag_bol = Dish.new("Spaghetti Bolognese", "£5.99")
    beef_stew = Dish.new("Beef Stew", "£6.50")
    dishes = Dishes.new
    dishes.add(spag_bol)
    dishes.add(beef_stew)
    c = Customer.new
    result = c.menu_view(dishes)
    output = [
      {description: "Spaghetti Bolognese", price: "£5.99"},
      {description: "Beef Stew", price: "£6.50"}
    ]
    expect(result).to eq output
  end

  xit "places order" do
    dishes = Dishes.new
    dishes.add(Dish.new("Spaghetti Bolognese", "£5.99"))
    dishes.add(Dish.new("Beef Stew", "£6.50"))
    s1 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes), 2)
    s1 = Selection.new(FindDish.new("Beef Stew", dishes), 3)
    o = Order.new
    o.add(s1)
    o.add(s2)
    c = Customer.new
    result = c.purchase(order)
    expect(result).to eq # => "Thank you! Your order was placed and will be delivered before 18:52"
  end

  xit "fails" do
    c = Customer.new
    o = Order.new
    expect { c.purchase(o) }.to raise_error "Your basket is empty!"
  end

  xit "views receipt" do
    dishes = Dishes.new
    dishes.add(Dish.new("Spaghetti Bolognese", "£5.99"))
    dishes.add(Dish.new("Beef Stew", "£6.50"))
    s1 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes), 2)
    s1 = Selection.new(FindDish.new("Beef Stew", dishes), 3)
    o = Order.new
    o.add(s1)
    o.add(s2)
    c = Customer.new
    c.purchase(order)
    result = c.view_receipt
    output = [
      {description: "Spaghetti Bolognese", qty: 2, line_total: "£11.98"},
      {description: "Beef Stew", qty: 3, line_total: "£13.00"},
      {order_total: "£24.98"}
    ]
    expect(result).to eq output
  end
end