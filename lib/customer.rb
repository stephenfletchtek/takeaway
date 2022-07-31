class Customer
  def initialize
    @orders = []
  end

  def menu_view(dishes) #dishes object
    dishes.map(&:view)
  end
    
  def purchase(order, time = Time.now) #order object
    fail "Your basket is empty!" if order.contents.empty?
    @orders << order   # future functionality: customer has order history
    promise_time = (time + 3600).strftime("%I:%M")
    "Thank you! Your order was placed and will be delivered before #{promise_time}"
    # *** send text message ***
  end

  def view_receipt(order = @orders[-1]) #order object
    o = order.map do |selection|
      a = selection.dish.description
      b = selection.qty
      c = selection.dish.price
      {description: a, qty: b, line_total: b * c}
    end
  end
end