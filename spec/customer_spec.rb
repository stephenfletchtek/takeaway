require 'customer'

RSpec.describe Customer do
  it "shows menu" do
    spag_bol = double(:spag_bol,
      view: {description: "Spaghetti Bolognese", price: "£5.99"})
    beef_stew = double(:beef_stew,
      view: {description: "Beef Stew", price: "£6.50"})
    dishes = double(:dishes)
    expect(dishes).to receive(:all).and_return([spag_bol, beef_stew])
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
    s1 = double :selection, dish: d1, qty: 2
    s2 = double :selection, dish: d2, qty: 3
    o = double :order, contents: [s1, s2]
    my_map = [
      {description: "Spaghetti Bolognese", qty: 2, line_total: 11.98},
      {description: "Beef Stew", qty: 3, line_total: 19.5}, 
    ]
    expect(s1).to receive(:[]).with(0).and_return(d1)
    expect(s1).to receive(:[]).with(1).and_return(2)
    expect(s1).to receive(:[]).with(0).and_return(d1)
    expect(s2).to receive(:[]).with(0).and_return(d2)
    expect(s2).to receive(:[]).with(1).and_return(3)   
    expect(s2).to receive(:[]).with(0).and_return(d2)
    order_total = {order_total: 31.48}
    expect(s1).to receive(:[]).with(0).and_return(d1)
    expect(s1).to receive(:[]).with(1).and_return(2)
    expect(s2).to receive(:[]).with(0).and_return(d2)
    expect(s2).to receive(:[]).with(1).and_return(3)   
    c = Customer.new
    c.purchase(o)
    result = c.view_receipt
    output = [
      {description: "Spaghetti Bolognese", qty: 2, line_total: 11.98},
      {description: "Beef Stew", qty: 3, line_total: 19.5},
      {order_total: 31.48}
    ]
    expect(result).to eq output
  end
end