require 'uri'
require 'net/http'

module Commands
  class Logout < SlackRubyBot::Commands::Base
    command 'logout' do |client, data, _match|
      client.typing channel: data.channel

      user = User.where(email: client.users[data.user].profile.email)
      user.delete
      client.say channel: data.channel, text: "Bye!", gif: "bye"
    end
  end
end
