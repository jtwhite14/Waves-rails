class Api::V1::UsersController < APIController
  def me
    @user = current_user
    respond_with @user
  end

  def create
  	@user = current_user
  	@user.update(user_params)
  	respond_with @user
  end

private

 	def user_params
 		params[:user].permit(:name, :avatar)
 	end
end
