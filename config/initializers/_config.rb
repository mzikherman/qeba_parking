module QebaParking
  mattr_accessor :config
end

QebaParking.config = {
  basic_auth_key: ENV['BASIC_AUTH_KEY'],
  basic_auth_password: ENV['BASIC_AUTH_PASSWORD'],
  available_spaces: (ENV['AVAILABLE_SPACES'] || 100).to_i
}
