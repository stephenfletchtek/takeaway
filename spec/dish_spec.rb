require 'dish'

RSpec.describe Dish do
  it "shows dish description" do
    dish = Dish.new("Spaghetti Bolognese", 5.99)
    result = dish.description
    expect(result).to eq "Spaghetti Bolognese"
  end

  it "shows dish price" do
    dish = Dish.new("Spaghetti Bolognese", 5.99)
    result = dish.price
    expect(result).to eq 5.99
  end

  it "shows dish 'view'" do
    dish = Dish.new("Spaghetti Bolognese", 5.99)
    result = dish.view
    expect(result).to eq ({description: "Spaghetti Bolognese", price: 5.99})
  end
end