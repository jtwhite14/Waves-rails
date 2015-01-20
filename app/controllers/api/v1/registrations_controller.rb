class Api::V1::RegistrationsController < APIController

	skip_before_filter :authenticate_user_from_token!
	skip_before_filter :authenticate_user!
	
	def create
		user = User.new(registration_params)
		Rails.logger.info user.inspect

		# # Merge params if this is a new user or an unregistered user
		# if user.new_record? || !user.registered
		# 	user.assign_attributes(registration_params.merge(registered: true))
		# end

		# Check if this user can be saved.
		if user.save
			sign_in(:user, user)
			user.ensure_authentication_token!
			render json: user
			return
		else
			warden.custom_failure!
			render :json=> error_message(user.errors.first), :status=>422
		end
	end

private
	def registration_params
    params[:registration].permit(:email, :name, :password, :avatar)
  end

  def error_message message_hash
  	message_hash.join(" ")
  end
end

# user = find_or_initalize by email
# if user.new_record? or !user.registered
	# set params

# if user.save

# else
