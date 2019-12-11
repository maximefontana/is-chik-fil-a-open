class User < ApplicationRecord
  geocoded_by :address, :latitude => :lat, :longitude => :lon
  after_validation :geocode

  def address
    [latitude, longitude].compact.join(', ')
  end
end
