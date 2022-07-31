require 'customer'

RSpec.describe Customer do
  it "shows menu" do
    spag_bol = double(:spag_bol,
      view: {description: "Spaghetti Bolognese", price: "£5.99"})
    beef_stew = double(:beef_stew,
      view: {description: "Beef Stew", price: "£6.50"})
    dishes = double(:dishes)
    # think about this later
    expect(dishes).to receive(:map)
      .and_yield(spag_bol)
      .and_yield(beef_stew)
      .and_return([spag_bol.view, beef_stew.view])
      c = Customer.new
    result = c.menu_view(dishes)
    output = [
      {description: "Spaghetti Bolognese", price: "£5.99"},
      {description: "Beef Stew", price: "£6.50"}
    ]
    expect(result).to eq output
  end

  it "places order" do
    s1 = double(:selection)
    s2 = double(:selection)
    o = double(:order, contents: [s1, s2])
    t = Time.new(2022, 07, 31, 10, 00, 00, +0100)
    c = Customer.new
    result = c.purchase(o, t)
    msg = "Thank you! Your order was placed and will be delivered before 11:00"
    expect(result).to eq msg
  end

  it "fails" do
    c = Customer.new
    o = double :order, contents: []
    expect { c.purchase(o) }.to raise_error "Your basket is empty!"
  end

  it "views receipt" do
    d1 = double :dish, description: "Spaghetti Bolognese", price: 5.99
    d2 = double :dish, description: "Beef Stew", price: 6.5
    dishes = double :dishes, all: [d1, d2]
    s1 = double :selection, dish: d1, qty: 2
    s2 = double :selection, dish: d2, qty: 3
    o = double :order, contents: [s1, s2]
    my_map = [
      {description: "Spaghetti Bolognese", qty: 2, line_total: "£11.98"},
      {description: "Beef Stew", qty: 3, line_total: "£13.00"},
      {order_total: "£24.98"}
    ]
    expect(o).to receive(:map).and_return(my_map)
      
    c = Customer.new
    c.purchase(o)
    result = c.view_receipt
    output = [
      {description: "Spaghetti Bolognese", qty: 2, line_total: "£11.98"},
      {description: "Beef Stew", qty: 3, line_total: "£13.00"},
      {order_total: "£24.98"}
    ]
    expect(result).to eq output
  end
end