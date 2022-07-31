require 'dishes'

RSpec.describe Dishes do
  it "adds 2 dishes and shows list" do
    spag_bol = double :dish, contents: "Spaghetti Bolognese", price: 5.99
    beef_stew = double :dish, contents: "Beef Stew", price: 6.5
    dishes = Dishes.new
    dishes.add(spag_bol)
    dishes.add(beef_stew)
    expect(dishes.all).to eq [spag_bol, beef_stew]
  end

  it "fails" do
    dishes = Dishes.new
    expect { dishes.all }.to raise_error "No dishes to show!"
  end
end