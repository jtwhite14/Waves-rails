class Api::V1::SessionsController < APIController

	def index
		@sessions = current_user.sessions.all
		respond_with @sessions
	end

	def show
		@session = current_user.sessions.find(params[:id])
		respond_with @session
	end

	def create
		@session = current_user.sessions.create({finalized: false})
		respond_with @session, location: api_v1_session_path(@session)
	end

	def update
		session = Session.unscoped { current_user.sessions.find(params[:id]) }
		@session = SessionService.new(session).finalize! session_params
		respond_with @session, location: api_v1_session_path(@session)
	end

	def upload
		@session = Session.unscoped { current_user.sessions.find(params[:id]) }
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
