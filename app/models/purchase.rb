class Purchase < ActiveRecord::Base
  PAYMENT_TYPES = [
                    ["Carta di credito", "credit_card"],
                    ["PayPal", "pay_pal"]
                  ]

  validates :user_id, :presence => true
  validates :pay_type, :presence => true,
            :inclusion => { :in => PAYMENT_TYPES.map{ |disp, value| value} }
  before_save :decrease_availability

  belongs_to :user
  has_many :tickets, :dependent => :destroy

  def add_tickets_from_cart(cart)
    cart.items.each do |item|
      tickets << Ticket.from_cart_item(item)
    end
  end

  def decrease_availability
    self.tickets.each do |ticket|
      ticket.ticket_type.availability -= ticket.quantity
      ticket.ticket_type.save
    end
  end

end
