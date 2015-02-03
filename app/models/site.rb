class Site < ActiveRecord::Base
  validates :address, :presence => true
  validates :city, :presence => true
  validates :name, :presence => true
  validates :description, :presence => true
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed?
  after_validation :geocode, :if => :city_changed?

  def full_address
    self.address + " " + self.city
  end

  has_many :stages
end
