class UserSerializer < ApplicationSerializer
  attributes :id, :authentication_token, :name, :email

end
