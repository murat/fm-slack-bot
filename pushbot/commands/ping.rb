require 'pry'

module Commands
  class Ping < SlackRubyBot::Commands::Base
    command 'ping' do |client, data, _match|
      client.typing channel: data.channel
      client.say channel: data.channel, text: "pong <@#{data.user}>", gif: "pong"
    end
  end
end
