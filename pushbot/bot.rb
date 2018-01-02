module Pushbot
  class Bot < SlackRubyBot::Bot

    help do
      title 'FM PushBot'
      desc 'FM\'e slackten post atmaya yarar.'

      command 'ping' do
        desc 'Bot aktivitesini test eder.'
      end

      command 'register' do
        desc 'Bot ile FM arasında bağlantı kurmanızı sağlar.'
        long_desc "Öncelikle FM de anahtarlık bölümünden bir anahtar oluşturun.\n" \
          'Ve mutlaka pushbot\'a özelden yazarak `register SECRET` şeklinde anahtarı verin.'
      end

      command 'push' do
        desc 'Botun FM\'e post atmasını sağlar.'
        long_desc "Öncelikle şunu belirtelim şuan için sadece Link tipi post atılabilir.\n" \
          "Ve herhangi bir kanalda `@pushbot push Link başlığı http://link.com` şeklinde paylaşımınızı yapın.\n" \
          "NOT: Bu komut kanaldaki diğer slack kullanıcıları tarafından da görülecektir.\n" \
          "NOT: Paylaşım önce FM admininin onayından geçecektir."
      end

      command 'logout' do
        desc 'Bot ile FM hesabının bağlantısını keser.'
      end
    end

  end
end
