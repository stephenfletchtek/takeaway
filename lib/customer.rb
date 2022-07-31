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
    promise_time = (time + 3600).strftime("%H:%M")
    "Thank you! Your order was placed and will be delivered before #{promise_time}"
    # *** send text message ***
  end

  def view_receipt(order = @orders[-1]) #order object
    output = order.contents.map do |sel|
      desc = sel[0].description
      qty = sel[1]
      price = sel[0].price
      {description: desc, qty: qty, line_total: qty * price}
    end
    total = order.contents.sum { |sel| sel[1] * sel[0].price }
    output << {order_total: total}
  end
end