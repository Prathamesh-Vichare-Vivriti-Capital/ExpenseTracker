class AuthenticateUser
  prepend SimpleCommand

  def initialize(email,password)
    @email = email
    @password = password
  end

  def call
    return JsonWebToken.encode(user_id: user.id) if (user and user.is_a?(User))
    return JsonWebToken.encode(admin_id: user.id) if (user and user.is_a?(Admin))
  end

  private

  attr_accessor :email, :password

  def user
    user = (User.find_by(email: email) || Admin.find_by(email: email))
    return user if user && user.authenticate(password)

    errors.add :user_authentication, "Invalid credentials"
    nil
  end
end
