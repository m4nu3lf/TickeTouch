class TicketType < ActiveRecord::Base
  validates :stage_id, :presence => true
  validates :description, :presence => true
  validates :price, :presence => true

  belongs_to :stage
  has_many :tickets
end
