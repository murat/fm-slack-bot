require 'uri'
require 'net/http'

module Commands
  class Push < SlackRubyBot::Commands::Base
    command 'push' do |client, data, _match|
      client.typing channel: data.channel
      return client.say channel: data.channel, text: ':unamused: Argüman vermedin ama.' if _match['expression'].blank?

      user = User.find_by(email: client.users[data.user].profile.email)

      return client.say channel: data.channel, text: ':unamused: Önce bir register lütfen.' if user.nil?

      url  = URI("#{ENV['FM_BASE_URL']}/api/v1/links")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = url.scheme == 'https'

      request                  = Net::HTTP::Post.new(url)
      request['Content-Type']  = 'application/json'
      request['Authorization'] = "Bearer #{user.token}"

      exp                      = _match['expression'].rpartition(' ')
      title                    = exp.first
      url                      = exp.last[1..-2]

      return client.say channel: data.channel, text: ':unamused: Düzgün bir link girer misin?' unless url =~ URI::DEFAULT_PARSER.make_regexp

      request.body = {
        link: {
          title: title,
          url: url
        }
      }.to_json

      response = http.request(request)
      body = JSON.parse(response.read_body)

      if response.code.to_i == 201
        client.say channel: data.channel, text: ":tada: #{body['message']} -> #{body['url']}"
      elsif response.code.to_i == 422
        errors = body['errors'].map{|k,v|"#{k.to_s.titleize} #{v.first}"}.join(', ')
        client.say channel: data.channel, text: ":unamused: #{errors}"
      elsif response.code.to_i == 401
        client.say channel: data.channel, text: ':unamused: Önce bir register yap lütfen (özele gel).'
      else
        client.say channel: data.channel, text: ':unamused: Biraz bekle lütfen.'
      end
    end
  end
end
