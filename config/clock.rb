require 'rubygems'
require 'bundler/setup'

require 'clockwork'
require './config/boot'
require './config/environment'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(POLL_TIME, 'Poll RSS Status') { GitHub::Status.execute }
