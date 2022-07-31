# USER STORIES 
As a customer
So that I can check if I want to order something
I would like to see a list of dishes with prices.

As a customer
So that I can order the meal I want
I would like to be able to select some number of several available dishes.

As a customer
So that I can verify that my order is correct
I would like to see an itemised receipt with a grand total.

As a customer
So that I am reassured that my order will be delivered on time
I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.

*** Use the twilio-ruby gem to implement this. You will need to use doubles too.

*** Fair warning: if you push your Twilio API Key to a public Github repository, anyone will be able to see and use it. What are the security implications of that? How will you keep that information out of your repository?

# DESIGN

         ┌────────────┐
         │Customer    │
         ├────────────┤
         │menu_view   │
         │            │
         │purchase    │
         │            │
         │view_receipt│
         └┬───────────┤
          │           │
          │           │
  ┌───────▼┐          │
  │Order   │          │
  ├────────┤          │
  │add     │          │
  │        │         ┌▼─────┐
  │remove  │         │Dishes│
  │        │         ├──────┤
  │contents│         │add   │
  └────┬───┘     ┌───►      │
       │         │   │all   │
  ┌────▼────┐    │   └───┬──┘
  │Selection│    │       │
  ├─────────┤    │       │
  │dish     │    │       │
  │         │    │       │
  │qty      │    │       │
  │         │    │   ┌───▼───────┐
  │view     │    │   │Dish       │
  └────┬────┘    │   ├───────────┤
       │         │   │description│
  ┌────▼───┐     │   │           │
  │FindDish│     │   │qty        │
  ├────────┤     │   │           │
  │find    ├─────┘   │view       │
  └────────┘         └───────────┘

```ruby
class Customer
  def initialize
    #orders
  end

  def menu_view(dishes) #dishes object
    # display all dishes
  end
    
  def purchase(order) #order object
    #add selection to orders
    #send text message
  end

  def view_receipt(order) #order object
    #show a selection object from orders list
  end
end

class Dishes
  def initialize
    # list of dishes
  end

  def add(dish) #dish object
    #add dish to list
  end

  def all
    # returns list of all dishes
  end
end

class Order
  def initialize
    # list of selections
  end

  def add(selection) # selection is a dish object and quantity
    #add selection to list
  end

  def remove(selection) # selection is a dish object and quantity
    #remove selection from list
  end

  def contents
    # returns order list
  end
end

class Dish
  def initialize(description, price)
  end

  def description
    #return description
  end

  def price
    # return price
  end

   def view
    returns {description: "", price: ""}
  end
end

class Selection
  def intialize(dish, qty)
    # dish object
    # qty
  end 

  def dish
    # return dish object
  end

  def qty
    #return qty
  end

  def view
    returns {dish: Dish.description, qty: Int}
  end
end

class FindDish
  def initialise(description, dishes)
    # description
    # all dishes
  end

  def find
    #return dish object found
  end
end
```

# Integration tests
```ruby
class Customer
  def initialize
    #orders
  end

  def menu_view(dishes) #dishes object
    # display all dishes
  end
    
  def purchase(order) #order object
    #add selection to orders
    #send text message
  end

  def view_receipt(order) #order object
    #show a selection object from orders list
  end
end

# 1
spag_bol = Dish.new("Spaghetti Bolognese", "£5.99")
beef_stew = Dish.new("Beef Stew", "£6.50")
dishes = Dishes.new
dishes.add(spag_bol)
dishes.add(beef_stew)
c = Customer.new
result = c.menu_view(dishes)
expect(result).to eq # => [{description: "Spaghetti Bolognese", price: "£5.99"},{description: "Beef Stew", price: "£6.50"}]

# 2
dishes = Dishes.new
dishes.add(Dish.new("Spaghetti Bolognese", "£5.99"))
dishes.add(Dish.new("Beef Stew", "£6.50"))
s1 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes), 2)
s1 = Selection.new(FindDish.new("Beef Stew", dishes), 3)
o = Order.new
o.add(s1)
o.add(s2)
c = Customer.new
result = c.purchase(order)
expect(result).to eq # => "Thank you! Your order was placed and will be delivered before 18:52"
# *** and send a text message! ***

# 3
dishes = Dishes.new
dishes.add(Dish.new("Spaghetti Bolognese", "£5.99"))
dishes.add(Dish.new("Beef Stew", "£6.50"))
s1 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes), 2)
s1 = Selection.new(FindDish.new("Beef Stew", dishes), 3)
o = Order.new
o.add(s1)
o.add(s2)
c = Customer.new
c.purchase(order)
result = c.view_receipt(order)
expect(result).to eq # => [{description: "Spaghetti Bolognese", qty: 2, line_total: "£11.98"},{description: "Beef Stew", qty: 3, line_total: "£13.00"},{order_total: "£24.98"}]

#4
spag_bol = Dish.new("Spaghetti Bolognese", 5.99)
beef_stew = Dish.new("Beef Stew", 6.5)
dishes = Dishes.new
dishes.add(spag_bol)
dishes.add(beef_stew)
expect(dishes.all) #=>[spag_bol, beef_stew]

#5
dishes = Dishes.new
dishes.add(Dish.new("Spaghetti Bolognese", 5.99))
dishes.add(Dish.new("Beef Stew", 6.5))
s1 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes), 2)
s2 = Selection.new(FindDish.new("Beef Stew", dishes), 3)
o = Order.new
o.add(s1)
o.add(s2)
o.add(s1)
expect(o.contents) #=> [s1, s2]

#6
dishes = Dishes.new
dishes.add(Dish.new("Spaghetti Bolognese", 5.99))
dishes.add(Dish.new("Beef Stew", 6.5))
s1 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes), 2)
s2 = Selection.new(FindDish.new("Beef Stew", dishes), 3)
s3 = Selection.new(FindDish.new("Spaghetti Bolognese", dishes), 1)
o = Order.new
o.add(s1)
o.add(s2)
o.remove(s3)
expect(o.contents) #=> [s1, s2]
```

# UNIT TESTS

```ruby


#2
dishes = Dishes.new
expect(dishes.all) #=>fail "No dishes to show!"
```