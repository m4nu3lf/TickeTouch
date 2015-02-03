require 'digest/sha1'

class Ticket < ActiveRecord::Base
  validates :quantity, :presence => :true
  before_save :gen_key_code

  belongs_to :ticket_type
  belongs_to :purchase

  def self.from_cart_item(cart_item)
    ticket = self.new
    ticket.ticket_type = cart_item.ticket_type
    ticket.quantity = cart_item.quantity
    ticket
  end

  def price
    self.ticket_type.price * self.quantity
  end

  private

  def gen_key_code
    self.key_code = Digest::SHA1.hexdigest(Time.new.to_s + "secret ;)").upcase[0..13]
  end

end
