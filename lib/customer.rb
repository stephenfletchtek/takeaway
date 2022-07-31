class Customer
  def initialize
    @orders = []
  end

  def menu_view(dishes) #dishes object
    dishes.map{ |dish| dish.view }
  end
    
  def purchase(order, time = Time.now) #order object
    fail "Your basket is empty!" if order.contents.empty?
    @orders << order   # future functionality: customer has order history
    promise_time = (time + 3600).strftime("%I:%M")
    "Thank you! Your order was placed and will be delivered before #{promise_time}"
    # *** send text message ***
  end

  def view_receipt(order) #order object
    #show a selection object from orders list
  end
end