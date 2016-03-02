class User < ActiveRecord::Base
  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])
    user.name = auth['info']['name']
    user.first_name = auth['info']['first_name']
    user.last_name = auth['info']['last_name']
    user.email = auth['info']['email']
    user.image = auth['info']['image']
    user.token = auth['credentials']['token']
    user.expires_at = auth['credentials']['expires_at']
    user.save
    user
  end
end
