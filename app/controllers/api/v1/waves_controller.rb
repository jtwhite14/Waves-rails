class Api::V1::WavesController < APIController

	def index
		# grab all users waves
		# we use rails helper here
		# pre-fetch model data
		# when you are finding all the waves 
		# all waves for user sorted by distance
		# 
		@waves = current_user.waves.includes(sessions: :observation).all
		if (params[:latitude] && params[:longitude])
			@waves = DistanceCollection.new(@waves).set_distance_from([params[:latitude], params[:longitude]]).sort_by(&:distance)
			@waves = @waves.take(params[:limit].to_i) if params[:limit]
		end
		respond_with @waves
	end

	def show
		# this is for a specific wave
		# .includes is data optimization
		# hit should with waves id
		# then set distance
		# curren_user.waves so you can only find waves for logged in user
		@wave = current_user.waves.includes(sessions: :observation).find(params[:id])
		if (params[:latitude] && params[:longitude])
			@wave = DistanceCollection.new([@wave]).set_distance_from([params[:latitude], params[:longitude]]).first
		end
		respond_with @wave, serializer: WaveDetailSerializer, root: :wave
	end

	def sessions
		@sessions = current_user.waves.includes(sessions: :observation).find(params[:id]).sessions.order(:timestamp)
		respond_with @sessions, root: :sessions
	end

	def create
		# wave service
		@wave = WaveService.new(current_user).create! wave_params
		respond_with @wave, location: api_v1_wave_path(@wave)
	end

private

	def wave_params
		# this dications what params are allowed.
		# slug may be depricated
		params[:wave].permit(:title, :latitude, :longitude, :slug)
	end
end
