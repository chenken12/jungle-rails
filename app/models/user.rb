class User < ActiveRecord::Base
  has_secure_password

  # user = User.find_by_email(params[:email])
  # if user && user.authenticate(params[:password])
  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
end
