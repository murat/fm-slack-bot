require 'sinatra/base'

class Web < Sinatra::Base
  get '/' do
    'Everything is OK.'
  end
end
