class Stage < ActiveRecord::Base
  validates :event_id, :presence => true
  validates :date_time, :presence => true
  validates :site_id, :presence => true

  belongs_to :event
  belongs_to :site
  has_many :ticket_types, :dependent => :destroy

  def distance_to(address)

    self.site.distance_to(address)
  end
end
