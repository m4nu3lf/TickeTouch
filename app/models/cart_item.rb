class CartItem
  attr_reader :ticket_type, :quantity
  def initialize(ticket_type, ticket_num)
    @ticket_type = ticket_type
    @quantity = ticket_num
  end

  def increment_quantity(ticket_num)
    @quantity += ticket_num
  end

  def title
    @ticket_type.stage.event.title
  end

  def price
    @ticket_type.price * @quantity
  end

  def available?
    self.ticket_type.availability >= quantity
  end
end