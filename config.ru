$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'
require 'pushbot'
require 'web'

Dotenv.load

Thread.abort_on_exception = true

Thread.new do
  begin
    Pushbot::Bot.run
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run Web
