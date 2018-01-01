require 'uri'
require 'net/http'

module Commands
  class Register < SlackRubyBot::Commands::Base
    command 'register' do |client, data, _match|
      client.typing channel: data.channel
      
      url  = URI("#{ENV['FM_BASE_URL']}/oauth/token")
      http = Net::HTTP.new(url.host, url.port)

      request                  = Net::HTTP::Post.new(url)
      request['Content-Type']  = 'application/json'

      request.body = {
        client_id: ENV['FM_CLIENT_ID'],
        grant_type: 'password',
        username: client.users[data.user].profile.email,
        password: _match['expression'],
        scope: ''
      }.to_json

      response = http.request(request)

      if response.code.to_i == 200
        response = JSON.parse(response.read_body)

        User.create(slack_id: data.user, email: client.users[data.user].profile.email, token: response['access_token'])

        client.say channel: data.channel, text: "Welcome to the jungle.", gif: "welcome"
      else
        client.say channel: data.channel, text: "Opps!!! napıyorsun sen hacı ya :unamused: Bi daha yapma lütfen.", gif: "angry"
      end
    end
  end
end
