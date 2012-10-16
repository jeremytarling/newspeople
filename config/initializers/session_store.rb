# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_newspeople_session',
  :secret      => '5e82dd10c13c2a7d55661436f7a0db19eb14d24f225f36911280fd38ffc9eaedd4f5f93112e58bbe6887486d959f4aa6c579eadff9473dee1068a72be827b230'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
