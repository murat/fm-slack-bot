require 'pry'

module Commands
  class Ping < SlackRubyBot::Commands::Base
    command 'ping' do |client, data, _match|
      client.typing channel: data.channel
      user = User.where(email: client.users[data.user].profile.email)
      msg = user.exists? ? "<#{user.first.email}> olarak register olmussun." : "Register olmamışsın."

      client.say channel: data.channel, text: "pong <@#{data.user}>! __(#{msg})__"
    end
  end
end
