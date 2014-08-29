CarrierWave.configure do |config|

  config.cache_dir = File.join(Rails.root, 'tmp', 'uploads')

  case Rails.env.to_sym

    when :development
      config.storage = :file
      config.root = File.join(Rails.root, 'public')

    when :production
      amazon = {}
      if File.exists? "config/secrets.yml"
        secrets = YAML::load(File.open("config/secrets.yml"))
        amazon = secrets['amazon']
      end

      # the following configuration works for Amazon S3
      config.storage          = :fog
      config.fog_credentials  = {
        provider:                 'AWS',
        aws_access_key_id:        amazon['key_id'],
        aws_secret_access_key:    amazon['secret_key'],
        region:                   amazon['s3_bucket_region']
      }
      config.fog_directory    = amazon['s3_bucket']

    else
      # settings for the local filesystem
      config.storage = :file
      config.root = File.join(Rails.root, 'public')
  end

end