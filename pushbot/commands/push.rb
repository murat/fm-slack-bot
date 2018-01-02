require 'uri'
require 'net/http'

module Commands
  class Push < SlackRubyBot::Commands::Base
    command 'push' do |client, data, _match|
      client.typing channel: data.channel
      return client.say channel: data.channel, text: ":unamused: Argüman vermedin ama." if _match['expression'].blank?

      exp                      = _match['expression'].rpartition(' ')
      title                    = exp.first
      url                      = exp.last[1..-2]
      
      return client.say channel: data.channel, text: ":unamused: Düzgün bir link girer misin?" unless url =~ URI::regexp

      user = User.where(email: client.users[data.user].profile.email)

      return client.say channel: data.channel, text: ":unamused: Önce bir register lütfen." unless user.exists?

      url  = URI("#{ENV['FM_BASE_URL']}/api/v1/links")
      http = Net::HTTP.new(url.host, url.port)

      request                  = Net::HTTP::Post.new(url)
      request['Content-Type']  = 'application/json'
      request['Authorization'] = "Bearer #{user.first.token}"
      request.body = {
        link: {
          title: title,
          url: url
        }
      }.to_json

      response = http.request(request)

      if response.code.to_i == 201
        response = JSON.parse(response.read_body)
        client.say channel: data.channel, text: ":tada: #{response['message']} -> #{response['url']}"
      elsif response.code.to_i == 401
        client.say channel: data.channel, text: ":unamused: Önce bir register yap lütfen (özele gel)."
      else
        client.say channel: data.channel, text: ":unamused: Biraz bekle lütfen."
      end
    end
  end
end
