class SessionService
	# this gest called when finalize happens
	# ignore 

	def initialize session
		@session = session
	end

	def finalize! params
		# Before adding session to wave
		# find wave
		# get timestamp
		# timestamp is rounded
		# we need to get session, then find closest hour to time stamp
		# 
		wave = Wave.find(params[:wave_id])

		# Find the current observation data, TODO: move this to observations, and do a remote search if not found.
		timestamp = DateTime.parse(params[:timestamp])

		if ((timestamp.to_time + 30.minutes) > DateTime.now.to_time)
			rounded_timestamp = (timestamp - 30.minutes).beginning_of_hour
		else
			rounded_timestamp = (timestamp + 30.minutes).beginning_of_hour
		end	

		# now we have wave and attached to buoy
		# from the buoy find all observation
		# find one that matches with closest one
		# user can change time stamp
		# if this happens will use user timestamp

		# if we upload session and we don't have a nearest data import 
		# then do one now and try again to get data
		# this can probably built out a little bit
		observation = wave.buoy.observations.find_by(timestamp: rounded_timestamp)
		unless observation
			begin
				Observation.import! buoy
				observation = wave.buoy.observations.find_by(timestamp: rounded_timestamp)
			rescue
			end
		end

		# attached observation data to session
		
		@session.update_attributes(
				wave: wave,
				observation: observation,
				notes: params[:notes],
				rating: params[:rating],
				timestamp: params[:timestamp],
				latitude: params[:latitude],
				longitude: params[:longitude],
				finalized: true
			)
	end

	# THIS IS NOT USED
	def create_from_web! params
		puts "THIS IS A NEW SESSIONNNNNNNN"
		# this was a hack for testing
		session = @user.sessions.create(
				notes: params[:notes],
				rating: params[:rating],
				session_photo: params[:session_photo]
			)
		
		Rails.logger.info session.session_photo.current_path

		# Get location data
		lat = EXIFR::JPEG.new(session.session_photo.current_path).gps.latitude
		lng = EXIFR::JPEG.new(session.session_photo.current_path).gps.longitude
		timestamp = EXIFR::JPEG.new(session.session_photo.current_path).date_time 

		Rails.logger.info lat
		Rails.logger.info lng
		Rails.logger.info timestamp

		buoy = Buoy.closest(origin: [lat, lng]).first

		# Set the wave, or create a new one
		wave = Wave.where(user: @user, buoy: buoy).first
		unless wave
			wave = Wave.create(user: @user, buoy: buoy, title: 'figure out default title')
		end

		# Find the current observation data, TODO: move this to observations, and do a remote search if not found.
		rounded_timestamp = (timestamp + 30.minutes).beginning_of_hour
		observation = buoy.observations.find_by(timestamp: rounded_timestamp)
		puts "this is the observation"
		puts observation
		unless observation
			#Observation.import_history! buoy
			observation = buoy.observations.find_by(timestamp: rounded_timestamp)
			# One thing we can do here is try again subtracking 1 hour
			# if nil subtrack hour and try again
			# the tide will be very incorrect with this
			# 
		end

		session.update_attributes({
			wave: wave,
			observation: observation,
			timestamp: timestamp
			})

		return session		
	end

end