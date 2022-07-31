require 'customer'

RSpec.describe Customer do
  it "shows menu" do
    spag_bol = Dish.new("Spaghetti Bolognese", 5.99)
    beef_stew = Dish.new("Beef Stew", 6.5)
    dishes = Dishes.new
    dishes.add(spag_bol)
    dishes.add(beef_stew)
    c = Customer.new
    result = c.menu_view(dishes)
    output = [
      {description: "Spaghetti Bolognese", price: 5.99},
      {description: "Beef Stew", price: 6.5}
    ]
    expect(result).to eq output
  end

  it "places order" do
    dishes = Dishes.new
    dishes.add(Dish.new("Spaghetti Bolognese", 5.99))
    dishes.add(Dish.new("Beef Stew", 6.5))
    s1 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes), 2)
    s2 = Selection.new(FindDish.new("Beef Stew", dishes), 3)
    order = Order.new
    order.add(s1)
    order.add(s2)
    c = Customer.new
    time = Time.now
    promise = (time + 3600).strftime("%H:%M")
    result = c.purchase(order, time)
    expect(result).to eq "Thank you! Your order was placed and will be delivered before #{promise}"
  end

  it "fails" do
    c = Customer.new
    o = Order.new
    expect { c.purchase(o) }.to raise_error "Your basket is empty!"
  end

  it "views receipt" do
    dishes = Dishes.new
    dishes.add(Dish.new("Spaghetti Bolognese", 5.99))
    dishes.add(Dish.new("Beef Stew", 6.5))
    d1 = FindDish.new("Spaghetti Bolognese", dishes)
    d2 = FindDish.new("Beef Stew", dishes)
    s1 = Selection.new(d1.find, 2)
    s2 = Selection.new(d2.find, 3)
    order = Order.new
    order.add(s1)
    order.add(s2)
    c = Customer.new
    c.purchase(order)
    result = c.view_receipt
    output = [
      {description: "Spaghetti Bolognese", qty: 2, line_total: 11.98},
      {description: "Beef Stew", qty: 3, line_total: 19.5},
      {order_total: 31.48}
    ]
    expect(result).to eq output
  end

  it "adds 2 dishes and shows list" do
    spag_bol = Dish.new("Spaghetti Bolognese", 5.99)
    beef_stew = Dish.new("Beef Stew", 6.5)
    dishes = Dishes.new
    dishes.add(spag_bol)
    dishes.add(beef_stew)
    expect(dishes.all).to eq [spag_bol, beef_stew]
  end
  
  it "adds 2 selections to the order" do
    dishes = Dishes.new
    dishes.add(Dish.new("Spaghetti Bolognese", 5.99))
    dishes.add(Dish.new("Beef Stew", 6.5))
    s1 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes).find, 2)
    s2 = Selection.new(FindDish.new("Beef Stew", dishes).find, 3)
    o = Order.new
    o.add(s1)
    o.add(s2)
    o.add(s1)
    expect(o.contents).to eq ({s1.dish => 4, s2.dish => 3})
  end

  it "removes a selection from the order" do
    dishes = Dishes.new
    dishes.add(Dish.new("Spaghetti Bolognese", 5.99))
    dishes.add(Dish.new("Beef Stew", 6.5))
    s1 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes).find, 2)
    s2 = Selection.new(FindDish.new("Beef Stew", dishes).find, 3)
    s3 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes).find, 1)
    o = Order.new
    o.add(s1)
    o.add(s2)
    o.remove(s3)
    expect(o.contents).to eq ({s1.dish => 1, s2.dish => 3})
  end

  it "fails" do
    dishes = Dishes.new
    dishes.add(Dish.new("Spaghetti Bolognese", 5.99))
    dishes.add(Dish.new("Beef Stew", 6.5))
    s1 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes).find, 2)
    s2 = Selection.new(FindDish.new("Beef Stew", dishes).find, 3)
    o = Order.new
    o.add(s1)
    expect { o.remove(s2) }.to raise_error "Item not in basket!"
  end

  it "finds a dish" do
    dishes = Dishes.new
    d1 = Dish.new("Spaghetti Bolognese", 5.99)
    d2 = Dish.new("Beef Stew", 6.5)
    dishes.add(d1)
    dishes.add(d2)
    f = FindDish.new("Spaghetti Bolognese", dishes)
    expect(f.find).to eq d1
  end

  it "shows selected dish" do
    d1 = Dish.new("Spaghetti Bolognese", 5.99)
    sel = Selection.new(d1, 2)
    expect(sel.dish).to eq d1
  end

  it "shows selected dish quantity" do
    d1 = Dish.new("Spaghetti Bolognese", 5.99)
    sel = Selection.new(d1, 2)
    expect(sel.qty).to eq 2
  end

  it "shows selected dish description" do
    d1 = Dish.new("Spaghetti Bolognese", 5.99)
    sel = Selection.new(d1, 2)
    expect(sel.view).to eq ({dish: d1.description, qty: 2})
  end
end