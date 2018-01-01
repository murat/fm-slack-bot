$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv'
require 'mongoid'
require 'pushbot'
require 'web'

Dotenv.load

Mongoid.load!("mongoid.yml")

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
