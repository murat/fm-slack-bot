require 'spec_helper'

describe Pushbot::Bot do
  def app
    Pushbot::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'

  it 'returns pong' do
    expect(message: "#{SlackRubyBot.config.user} ping", channel: 'pushbot-testing').to respond_with_slack_message('pong <@user>')
  end
end
