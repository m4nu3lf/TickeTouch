class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add_ticket_type(ticket_type, ticket_num)
    current_item = @items.find {|item| item.ticket_type == ticket_type}
    if current_item
      current_item.increment_quantity(ticket_num)
    else
      @items << CartItem.new(ticket_type, ticket_num)
    end
  end

  def total_price
    @items.sum{|item| item.price}
  end

  def available?
    @items.select{ |item| item.available? == false}.size == 0
  end

end