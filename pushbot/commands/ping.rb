require 'uri'
require 'net/http'

module Commands
  class Ping < SlackRubyBot::Commands::Base
    command 'ping' do |client, data, _match|
      is_logged = false
      client.typing channel: data.channel
      user = User.where(email: client.users[data.user].profile.email)

      if user.exists?
        token = user.token

        url  = URI("#{ENV['FM_BASE_URL']}/api/v1/ping")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = url.scheme == 'https'

        request                  = Net::HTTP::Get.new(url)
        request['Content-Type']  = 'application/json'
        request['Authorization'] = "Bearer #{token}"

        response = http.request(request)
        if response.code.to_i == 200
          is_logged = true
        end
      end

      msg = user.exists? && is_logged ? "<#{user.first.email}> olarak register olmussun." : "Register olmamışsın."

      client.say channel: data.channel, text: "pong <@#{data.user}>! __(#{msg})__"
    end
  end
end
