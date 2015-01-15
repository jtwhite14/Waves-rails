class Api::V1::BuoysController < APIController
	before_filter :authenticate_user_from_token!, :except => [:create]
	before_filter :authenticate_user!, :except => [:create]

	def index
		@buoys = Buoy.all
		respond_with @buoys
	end


end
