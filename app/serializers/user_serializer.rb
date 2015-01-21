class UserSerializer < ApplicationSerializer
  attributes :id, :authentication_token, :name, :email, :avatar_url

  def avatar_url
  	object.avatar.thumb.url ? object.avatar.thumb.url : "" 
  end

end
