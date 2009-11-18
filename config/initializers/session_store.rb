# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hasty_session',
  :secret      => 'd442fe13bc1aac3ad88a9bb290bd5787bb6552a5b3d8f3463d4dbada6a416f9c7a6580e9d14183246d11ddcf87f90cc80a2fef89bf9b7c2238d641657e538a3d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
