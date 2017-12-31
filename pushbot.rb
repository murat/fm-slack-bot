require 'slack-ruby-bot'
require 'yaml'

Dir['./pushbot/commands/*.rb'].each { |f| require f }

require 'pushbot/bot'
