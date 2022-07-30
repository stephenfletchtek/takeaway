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

       ┌─────────────┐
       │ Customer    │
       ├─────────────┤
       │ menu_view   │
       │             │
       │ order       │
       │             ├───────────────┐
       │ view_receipt│               │
       └─┬─────────┬─┘               │
         │         │                 │
 ┌───────▼──┐  ┌───▼─────────┐  ┌────▼────┐
 │FormatDish│  │ ViewReceipt │  │Selection│
 ├──────────┤  ├─────────────┤  ├─────────┤
 │format    │  │ view        │  │add      │
 │          │  │             │  │         │
 │          │  │             │  │remove   │
 └───────┬──┘  └─┬───────────┘  └─────────┘
         │       │
       ┌─▼───────▼───┐
       │ Dish        │
       ├─────────────┤
       │ Description │
       │             │
       │ Price       │
       └─────────────┘

```ruby
class Customer
  def initialize
    #orders
  end

  def menu_view(dishes) #dishes object
    # display all dishes
  end
    
  def complete(order) #order object
    #add selection to orders
    #send text message
  end

  def view_receipt(order) #order object
    #show a selection object from orders list
  end
ends

class Dishes
  def initialize
    # list of dishes
  end

  def add(dish) #dish object
    #add dish to list
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
end

class Selection
  def intialize(description, qty)
    # dish object
    # qty
  end 

  def dish
    # return dish object
  end

  def qty
    #return qty
  end
end

class FindDish
  def initialise(description, dishes)
    # dish found
  end

  def find
    #return dish object found
  end
end

class FormatDish
  def view(dish) # a dish object
    returns {description: "", price: ""}
  end
end

class FormatSelection
  def view(selection) # a selection object
    returns {dish: Dish.description, qty: Int}
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
end

```