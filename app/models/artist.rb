class Artist < ActiveRecord::Base
  validates :art_name, :presence => true
  validates :name, :presence => true
  validates :biography, :presence => true

  has_and_belongs_to_many :events
end
