require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick,
    convert_command:  `which convert`.strip.presence || '/usr/local/bin/convert',
    identify_command: `which identify`.strip.presence || '/usr/local/bin/identify'

  protect_from_dos_attacks true

  secret '09e76f03f995604a44904eada6cec9a5a7450fdd5705323b87d2d12ee2aa8bf0'

  url_format '/images/dynamic/:job/:basename.:ext'

  fetch_file_whitelist /public/

  fetch_url_whitelist /.+/
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware