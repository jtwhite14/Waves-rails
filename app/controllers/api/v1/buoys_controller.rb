class Api::V1::BuoysController < APIController
	skip_before_filter :authenticate_user_from_token!, :except => [:create]
	skip_before_filter :authenticate_user!, :except => [:create]

	def index
		# @buoys = Buoy.page(params[:page]).per(5).includes(:current_observation)
		# respond_with @buoys, serializer: PaginationSerializer
		@buoys = Buoy.all.includes(:current_observation)
		expires_in 1.hour, :public => true
		render json: to_json(buoys: @buoys)
	end

	def show
		@buoy = Buoy.find(params[:id])
		respond_with @buoy
	end

	def to_json(thing)
      thing.to_json({include: {
        current_observation: {},
      }})
    end


end
