class Api::V1::BuoysController < APIController
	skip_before_filter :authenticate_user_from_token!, :except => [:create]
	skip_before_filter :authenticate_user!, :except => [:create]

	def index
		# @buoys = Buoy.page(params[:page]).per(5).includes(:current_observation)
		# respond_with @buoys, serializer: PaginationSerializer
		@buoys = Buoy.all.includes(:current_observation)
		expires_in 1.hour, :public => true
		respond_with @buoys, root: :buoys
	end


end
