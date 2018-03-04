require 'slack-ruby-bot'
require 'yaml'

Dir['./pushbot/models/*.rb'].each { |f| require f }
Dir['./pushbot/commands/*.rb'].each { |f| require f }

require 'pushbot/bot'

Mongoid.raise_not_found_error = false

SlackRubyBot.configure do |config|
  config.send_gifs = false
end
