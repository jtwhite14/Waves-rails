class Api::V1::UsersController < APIController
  def me
    @user = current_user
    respond_with @user, root: :user
  end
end
