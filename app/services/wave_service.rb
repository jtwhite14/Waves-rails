class WaveService

	# this creates waves
	# pass in user
	# user.waves.create
	# take params and then assign buoy to wave
	# find the closest buoy
	# now this waves belongs to this buoy sort of

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