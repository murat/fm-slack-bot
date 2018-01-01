require 'slack-ruby-bot'
require 'yaml'

Dir['./pushbot/models/*.rb'].each { |f| require f }
Dir['./pushbot/commands/*.rb'].each { |f| require f }

require 'pushbot/bot'

SlackRubyBot.configure do |config|
  config.send_gifs = true
end