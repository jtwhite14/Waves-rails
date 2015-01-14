class WaveService

	def initialize user
		@user = user
	end

	def create! params
		wave = @user.waves.create(
				title: params[:slug],
				slug: params[:slug], 
				latitude: params[:latitude], 
				longitude: params[:longitude],
		 		buoy: Buoy.closest(origin: [params[:latitude], params[:longitude]]).first
		)
	end
end