CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"       

  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      =>  ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  =>  ENV['AWS_SECRET_ACCESS_KEY'],
  }
  config.fog_directory  = ENV['FOG_DIRECTORY']                             # required
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  config.asset_host = "http://d9jfjr70cs741.cloudfront.net"
  config.fog_public     = true

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  end
  if Rails.env.development?
	  CarrierWave.configure do |config|
	    config.storage = :file
	  end
	end
	if Rails.env.production? || Rails.env.staging?
	  CarrierWave.configure do |config|
	    config.storage = :fog
	  end
	end
end