class FindDish
  def initialize(description, dishes)
    @description = description
    @dishes = dishes.all
  end

  def find
    @dishes.each { |dish| return dish if dish.description == @description }
  end
end