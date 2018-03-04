require 'uri'
require 'net/http'

module Commands
  class Logout < SlackRubyBot::Commands::Base
    command 'logout' do |client, data, _match|
      client.typing channel: data.channel

      user = User.find_by(email: client.users[data.user].profile.email)
      user.delete

      client.say channel: data.channel, text: ':hand: Allaha emanet!'
    end
  end
end
