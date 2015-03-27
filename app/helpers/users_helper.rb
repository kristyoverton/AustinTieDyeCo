module UsersHelper
	def random_fact(lat,lon)
		if lat >= 30.32 && lat <= 30.36 && lon >= -98.08 && lon <= -98.15
			return "Hey, you're near Hamilton Pool. Don't drop your phone in the water!"
		elsif
			lat >= 47.609 && lat >= 30.36 && lon >= -122.19 && lon <= -122.2
			return "Washington?? That's not Texas. What the heck are you doing out there?"
		end
	end

end
