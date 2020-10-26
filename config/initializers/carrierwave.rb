CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'C4DWBBTZXVXIGD6GMMEZ',
    :aws_secret_access_key  => 'eIEFD3u3RYrAjSBZr7VmgDU17Di0eyb7XqEl4tB47oE',
    :region                 => 'sfo2',
    :endpoint               => 'https://sfo2.digitaloceanspaces.com'
  }
  config.fog_directory  = Rails.application.credentials.digitalocean_spaces_bucket
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  config.fog_public = false
  config.asset_host = "https://sfo2.digitaloceanspaces.com"
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
end
