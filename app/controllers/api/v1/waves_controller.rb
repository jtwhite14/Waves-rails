class Api::V1::WavesController < APIController

	def index
		@waves = Wave.all
		respond_with @waves
	end

	def show
		@wave = current_user.waves.find(params[:id])
		respond_with @wave
	end

	def sessions
		@sessions = current_user.waves.find(params[:id]).sessions.order(:timestamp)
		respond_with @sessions
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
