class AlertsController < AdminController

	# get all users
	def index
  	@users = User.all
    # for each user id
    @users.each do |item|
      puts "WE HAVE USERS HERE"

      @sessions = Session.where(user_id: item.id)
      @sessions.each do |sesh|
        @observation = Observation.where(id: sesh.observation_id).first
        puts "WE HAVE Observations"

        if(@observation != nil)
          #puts @observation.as_json
          @buoy_data = Observation.where(buoy_id: @observation["buoy_id"]).last

          session_wave_height = @observation["wave_height"]
          session_swell_height = @observation["swell_height"]
          session_average_wave_period = @observation["average_wave_period"]

          current_wave_height = @buoy_data["wave_height"]
          current_swell_height = @buoy_data["swell_height"]
          current_average_wave_period = @buoy_data["average_wave_period"]

          puts session_average_wave_period
          puts current_average_wave_period
          #puts @buoy_data.as_json
        end

      end

    end

	end

	private
		def

		end
	end


end
