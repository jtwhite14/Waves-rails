class WaveService

	def initialize user
		@user = user
	end

	def create! params
		wave = @user.waves.create(title: params[:title], buoy: Buoy.closest(origin: [params[:latitude], params[:longitude]]).first)
	end
end