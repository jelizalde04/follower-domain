require 'jwt'

class JwtService
  SECRET = ENV['JWT_SECRET']

  def self.decode(token)
    decoded = JWT.decode(token, SECRET, true, algorithm: 'HS256')
    decoded[0]
  rescue JWT::DecodeError
    nil
  end
end
