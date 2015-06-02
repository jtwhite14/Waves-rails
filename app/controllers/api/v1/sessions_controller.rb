class Api::V1::SessionsController < APIController

	# this is the more complicated part
	# this is due to horrible performance for uploading session
	# if not on wifi was super slow
	# image upload is async
	# create session -> call create method

	def index
		@sessions = current_user.sessions.all
		respond_with @sessions
	end

	def show
		@session = current_user.sessions.find(params[:id])
		respond_with @session
	end

	def create
		# create dummy session on server so I can get id
		# happens very fast
		# we need to do things in paralell so we can tie back together
		puts "******* Running create session ****8"
		@session = current_user.sessions.create
		respond_with @session, location: api_v1_session_path(@session)
	end

	def update
		# this takes session params just not session photo
		# once user rates and takes notes
		# take id and update record
		session = current_user.sessions.find(params[:id])
		@session = SessionService.new(session).finalize! session_params
		respond_with @session, location: api_v1_session_path(@session)
	end

	def upload
		# this is were we attached photo to session
		# cloudinary is third party service
		# get photo send to cloudiary happens in background
		# once processed we get an id back
		# backend server knows which cloudinary photo to attach
		# essentially photo upload service
		# will do cool things like croping and other things like that
		@session = current_user.sessions.find(params[:id])
		@session.session_photo = Cloudinary::Utils.signed_preloaded_image(params[:session_photo])
		@session.save
		respond_with @session, location: api_v1_session_path(@session)
	end

	def destroy
		@session = current_user.sessions.find(params[:id])
		@session.destroy!
		render :json => { "message" => "ok" }, :status => 200
	end

private

	def session_params
		params[:session].permit(:latitude, :longitude, :timestamp, :notes, :rating, :wave_id, :session_photo)
	end
end
