# Fazlamesai.net slack botu

Fazlamesai.net'e slack grubu üzerinden `pushbot push yazının güzel başlığı http://yainin.linki` şeklinde kısa bir komut ile link göndermeye yarayan bot.

## Kurulum

```
git clone git@github.com:muratbsts/fm-slack-bot.git
cd fm-slack-bot
cp .env.example .env
vim .env # gereken bilgileri verin
bundle install
foreman start # ve ya web: bundle exec puma -p 5000
```

Hepsi bu...
