module UsersHelper
	#By default, methods defined in any helper file are automatically available in any view, but for convenience we’ll put the gravatar_for method in the file for helpers associated with the Users controller. As noted at the Gravatar home page, Gravatar URLs are based on an MD5 hash of the user’s email address. In Ruby, the MD5 hashing algorithm is implemented using the hexdigest method, which is part of the Digest library:
	# Returns the Gravatar (http://gravatar.com/) for the given user.
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
