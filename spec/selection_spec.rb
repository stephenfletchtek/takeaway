require 'selection'

RSpec.describe Selection do
  it "shows selected dish" do
    d1 = double :dish, description: "Spaghetti Bolognese"
    sel = Selection.new(d1, 2)
    expect(sel.dish).to eq d1
  end

  it "shows selected dish quantity" do
    d1 = double :dish, description: "Spaghetti Bolognese"
    sel = Selection.new(d1, 2)
    expect(sel.qty).to eq 2
  end

  it "shows selected dish description" do
    d1 = double :dish, description: "Spaghetti Bolognese"
    sel = Selection.new(d1, 2)
    expect(sel.view).to eq ({dish: d1.description, qty: 2})
  end
end