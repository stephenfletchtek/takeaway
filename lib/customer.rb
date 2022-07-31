class Customer
  def initialize
    @orders = []
  end

  def menu_view(dishes) #dishes object
    dishes.all.map(&:view)
  end
    
  def purchase(order, time = Time.now) #order object
    fail "Your basket is empty!" if order.contents.empty?
    @orders << order   # future functionality: customer has order history
    promise_time = (time + 3600).strftime("%I:%M")
    "Thank you! Your order was placed and will be delivered before #{promise_time}"
    # *** send text message ***
  end

  def view_receipt(order = @orders[-1]) #order object
    output = order.map do |sel|
      desc = sel.dish.description
      qty = sel.qty
      price = sel.dish.price
      {description: desc, qty: qty, line_total: "£#{qty * price}"}
    end
    output << order.sum { |sel| "£#{sel.qty * sel.dish.price }" }
  end
end