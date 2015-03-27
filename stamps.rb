# Authenticate you stamps.com credentials
Stamps.configure do |config|
  config.integration_id = 'a6b87060-ec48-4362-ae70-4bf019debd44'
  config.username       = 'WhileTrueDo'
  config.password       = 'postage1'
end

puts Stamps.account