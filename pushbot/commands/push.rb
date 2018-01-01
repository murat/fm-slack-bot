require 'uri'
require 'net/http'

module Commands
  class Push < SlackRubyBot::Commands::Base
    command 'push' do |client, data, _match|
      client.typing channel: data.channel

      user = User.where(email: client.users[data.user].profile.email)

      if !user.exists?
        client.say channel: data.channel, text: "Opps!!! Önce bir register lütfen.", gif: "please"
      else
        url  = URI("#{ENV['FM_BASE_URL']}/api/v1/links")
        http = Net::HTTP.new(url.host, url.port)

        request                  = Net::HTTP::Post.new(url)
        request['Content-Type']  = 'application/json'
        request['Authorization'] = "Bearer #{user.first.token}"
        exp                      = _match['expression'].rpartition(' ')

        request.body = {
          link: {
            title: exp.first,
            url: exp.last[1..-2]
          },
          user: client.users[data.user].profile.email
        }.to_json

        response = http.request(request)

        if response.code.to_i == 201
          response = JSON.parse(response.read_body)
          client.say channel: data.channel, text: "#{response['message']} -> #{response['url']}"
        elsif response.code.to_i == 401
          client.say channel: data.channel, text: "Opps!!! Önce bir register lütfen.", gif: "please"
        else
          client.say channel: data.channel, text: "Opps!!! napıyorsun sen hacı ya :unamused: Biraz bekle lütfen.", gif: "angry"
        end
      end
    end
  end
end
