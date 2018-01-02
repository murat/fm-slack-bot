require 'uri'
require 'net/http'

module Commands
  class Register < SlackRubyBot::Commands::Base
    command 'register' do |client, data, _match|
      client.typing channel: data.channel
      
      return client.say channel: data.channel, text: ":unamused: Token vermedin ama." if _match['expression'].blank?

      exp                      = _match['expression'].rpartition(' ')
      token                    = exp.last
      
      url  = URI("#{ENV['FM_BASE_URL']}/api/v1/ping")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = url.scheme == 'https'

      request                  = Net::HTTP::Get.new(url)
      request['Content-Type']  = 'application/json'
      request['Authorization'] = "Bearer #{exp.last}"
      request.body = {
        email: client.users[data.user].profile.email
      }.to_json

      response = http.request(request)

      if response.code.to_i == 200
        User.create(slack_id: data.user, email: client.users[data.user].profile.email, token: exp.last)
        client.say channel: data.channel, text: ":tada: Hoşgeldin!.."
      else
        client.say channel: data.channel,
          text: ":unamused: Lütfen doğru düzgün bir token ver. Ha, bir de slack ve fazlamesai.net email'in aynı olmak zorunda maalesef."
      end
    end
  end
end
