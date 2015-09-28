# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
#BsuirBlogs::Application.config.secret_key_base = '4b61a42d8a12e0c7df0a696e997bf51d6e056a4ad63b5e5e08f3b8a53e1aaa2f8f24f4aace2993bd8cb07160b0dda4ef86bcb2188484ba49d7af170a247cc075'
require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

BsuirBlogs::Application.config.secret_key_base = secure_token