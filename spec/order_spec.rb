require 'order'

RSpec.describe Order do
  it "adds 2 selections to the order" do
    d1 = double :dish, description: "Spaghetti Bolognese", price: 5.99
    d2 = double :dish, description: "Beef Stew", price: 6.5
    s1 = double :selection, dish: d1, qty: 2
    s2 = double :selection, dish: d2, qty: 3 
    o = Order.new
    o.add(s1)
    o.add(s2)
    o.add(s1)
    expect(o.contents).to eq ({d1 => 4, d2 => 3})
  end

  it "removes a selection from the order" do
    d1 = double :dish, description: "Spaghetti Bolognese", price: 5.99
    d2 = double :dish, description: "Beef Stew", price: 6.5
    s1 = double :selection, dish: d1, qty: 2
    s2 = double :selection, dish: d2, qty: 3 
    s3 = double :selection, dish: d1, qty: 1
    o = Order.new
    o.add(s1)
    o.add(s2)
    o.remove(s3)
    expect(o.contents).to eq ({d1 => 1, d2 => 3})
  end
end