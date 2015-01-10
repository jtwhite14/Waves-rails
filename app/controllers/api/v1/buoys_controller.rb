class Api::V1::BuoysController < APIController

	def index
		@buoys = Buoy.all
		respond_with @buoys
	end


end
