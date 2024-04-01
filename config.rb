# Replace the 'config_from_url' string value below with your
# product environment's credentials, available from your Cloudinary console.
# =====================================================

require 'cloudinary'

Cloudinary.config_from_url("cloudinary://API_KEY:API_SECRET@CLOUD_NAME")
Cloudinary.config do |config|
  config.secure = true
end