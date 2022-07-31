class Dishes
  def initialize
    @list = []
  end

  def add(dish) #dish object
    @list << dish
  end

  def all
    fail "No dishes to show!" if @list.empty?
    @list
  end
end