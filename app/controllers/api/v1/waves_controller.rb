class Api::V1::WavesController < APIController

	def index
		@waves = current_user.waves.all
		if (params[:latitude] && params[:longitude])
			@waves = DistanceCollection.new(@waves).set_distance_from([params[:latitude], params[:longitude]]).sort_by(&:distance)
			@waves = @waves.take(params[:limit].to_i) if params[:limit]
		end
		respond_with @waves
	end

	def show
		@wave = current_user.waves.includes(sessions: :observation).find(params[:id])
		respond_with @wave, serializer: WaveDetailSerializer, root: :wave
	end

	def sessions
		@sessions = current_user.waves.includes(sessions: :observation).find(params[:id]).sessions.order(:timestamp)
		respond_with @sessions, root: :sessions
	end

	def create
		@wave = WaveService.new(current_user).create! wave_params
		respond_with @wave, location: api_v1_wave_path(@wave)
	end

private

	def wave_params
		params[:wave].permit(:title, :latitude, :longitude, :slug)
	end
end
