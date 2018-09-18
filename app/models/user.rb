class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_user_role

  def assign_user_role
    self.add_role(:user)
  end

  def generate_access_token(app)
    Doorkeeper::AccessToken.find_or_create_for(app, id, 'user read and write preference', nil, true)
  end

  # def generate_access_token(app)
  #   Doorkeeper::AccessToken.find_or_create_for(app, id, 'user read and write preference', 8.hours, true)
  # end
end
