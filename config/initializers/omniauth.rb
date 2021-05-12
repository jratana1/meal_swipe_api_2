Rails.application.config.middleware.use OmniAuth::Builder do
    configure do |config|
        config.path_prefix = '/auth'
    end
    provider :google_oauth2, Rails.application.credentials.google[:client_id], Rails.application.credentials.google[:client_secret]
    provider :facebook, Rails.application.credentials.facebook[:app_id], Rails.application.credentials.facebook[:app_secret]
end

# token_verifier = OmniAuth.config.before_request_phase # omniauth-rails_csrf_protection
# OmniAuth.config.before_request_phase = proc do |env|
#   begin
#     token_verifier&.call(env)
#   rescue ActionController::InvalidAuthenticityToken => e
#     OmniAuth::FailureEndpoint.new(env).redirect_to_failure
#   end
# end