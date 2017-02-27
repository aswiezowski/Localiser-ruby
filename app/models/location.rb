class Location < ActiveRecord::Base
  
  Radius = 6371
  
  validates :latitude, :longitude, :code, presence: true
  validates :code, uniqueness: true
  validates :latitude, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
  validates :longitude, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
  
  # Haversine formula
  def distance(location)
    latDistance = toRadians(location.latitude - latitude)
    lonDistance = toRadians(location.longitude - longitude)
    a = Math::sin(latDistance / 2) * Math::sin(latDistance / 2) + Math::cos(toRadians(latitude)) * Math::cos(toRadians(location.latitude)) * Math::sin(lonDistance / 2) * Math::sin(lonDistance / 2)
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a));
    Radius * c * 1000
  end
  
  def toRadians(angle)
    angle*Math::PI/180
  end
end
