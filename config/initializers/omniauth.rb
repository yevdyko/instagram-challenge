Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
                      image_size: { width: 152, height: 152 },
                      secure_image_url: true
end

OmniAuth.config.logger = Rails.logger

OmniAuth.config.on_failure = Proc.new do |env|
  Users::OmniauthCallbacksController.action(:failure).call(env)
end
