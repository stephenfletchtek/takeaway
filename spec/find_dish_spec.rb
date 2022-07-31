require 'find_dish'

RSpec.describe FindDish do
  it "finds a dish" do
    d1 = double :dish, description: "Spaghetti Bolognese", price: 5.99
    d2 = double :dish, description: "Beef Stew", price: 6.5
    dishes = double :dishes
    expect(dishes).to receive(:add)
    dishes.add(d1)
    expect(dishes).to receive(:add)
    dishes.add(d2)
    expect(dishes).to receive(:all).and_return([d1, d2])
    f = FindDish.new("Spaghetti Bolognese", dishes)
    expect(f.find).to eq d1
  end
end