class SessionService

	def initialize session
		@session = session
	end

	def finalize! params
		wave = Wave.find(params[:wave_id])

		# Find the current observation data, TODO: move this to observations, and do a remote search if not found.
		rounded_timestamp = (DateTime.parse(params[:timestamp]) + 30.minutes).beginning_of_hour
		observation = wave.buoy.observations.find_by(timestamp: rounded_timestamp)
		unless observation
			begin
				Observation.import! buoy
				observation = wave.buoy.observations.find_by(timestamp: rounded_timestamp)
			rescue
			end
		end

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

	def create_from_web! params

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
		unless observation
			#Observation.import_history! buoy
			observation = buoy.observations.find_by(timestamp: rounded_timestamp)
		end

		session.update_attributes({
			wave: wave,
			observation: observation,
			timestamp: timestamp
			})

		return session		
	end

end