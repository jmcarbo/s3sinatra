require "clockwork"
require 'logger'
require 'securerandom'


module Clockwork 
  handler do |job|
    case job
      when /backup.job/
        @logger.info "Running #{job}"
    end 
  end


  #`mkdir -p storage`
  @logger = Logger.new(STDOUT)
  every(1.minute, 'backup.job')
end

