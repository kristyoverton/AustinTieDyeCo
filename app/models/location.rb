class Location < ActiveRecord::Base
	validates :lat, presence: true
	validates :long, presence: true

	def self.nearby(lat,lon)
		where("lat > ?", lat-0.01) && where('lat < ?', lat+0.01) && where("long > ?",lon-0.01) && where('long < ?',lon+0.01)
	end
end
