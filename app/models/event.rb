class Event < ActiveRecord::Base
  validates :title, :presence => true
  validates :description, :presence => true

  has_many :ticket_types
  has_many :stages, :dependent => :destroy
  has_and_belongs_to_many :artists, :uniq => :true


  def nearby_stages(address, a, b)
    nearby_stages = self.stages.select do |stage|
      dist = stage.distance_to(address)
      puts "distance" + dist.to_s
      fuzzify_distance(dist, a, b) > 0.5
    end
  end

  private

  def fuzzify_distance(dist, a, b)
    if dist <= a
      1
    else if dist > a and dist < b
           (b-dist)/(b-a)
         else if dist >= b
                0
              end
         end
    end
  end

end
