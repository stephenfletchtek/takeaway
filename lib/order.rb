class Order
  def initialize
    @hash = Hash.new(0)
  end

  def add(selection)
    @hash[selection.dish] += selection.qty
  end

  def remove(selection)
    fail "Basket is empty!" if @hash.empty?
    @hash[selection.dish] -= selection.qty
  end

  def contents
    @hash
  end
end