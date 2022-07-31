require 'customer'

RSpec.describe Customer do
  it "shows menu" do
    spag_bol = double(:spag_bol,
      view: {description: "Spaghetti Bolognese", price: "£5.99"})
    beef_stew = double(:beef_stew,
      view: {description: "Beef Stew", price: "£6.50"})
    dishes = double(:dishes)
    # think about this later
    expect(dishes).to receive(:map).and_return([spag_bol.view, beef_stew.view])
    c = Customer.new
    result = c.menu_view(dishes)
    output = [
      {description: "Spaghetti Bolognese", price: "£5.99"},
      {description: "Beef Stew", price: "£6.50"}
    ]
    expect(result).to eq output
  end

  it "places order" do
    # dishes = Dishes.new
    # dishes.add(Dish.new("Spaghetti Bolognese", "£5.99"))
    # dishes.add(Dish.new("Beef Stew", "£6.50"))
    # s1 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes), 2)
    # s1 = Selection.new(FindDish.new("Beef Stew", dishes), 3)
    # o = Order.new
    # o.add(s1)
    # o.add(s2)
    s1 = double(:selection)
    s2 = double(:selection)
    o = double(:order, contents: [s1, s2])
    t = Time.new(2022, 07, 31, 10, 00, 00, +0100)
    c = Customer.new
    result = c.purchase(o, t)
    msg = "Thank you! Your order was placed and will be delivered before 11:00"
    expect(result).to eq msg
  end
end