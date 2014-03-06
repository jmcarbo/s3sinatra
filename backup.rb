require 'rubygems'
require 'active_record'
require 'active_support/core_ext' 


%w(file_info bit bucket git_bucket slot user torrent torrent_peer).each {|r| require "#{File.dirname(__FILE__)}/lib/sinatra-s3/models/#{r}" }

S3_ENV = :production
def config
  @config ||= YAML.load_file("s3.yml")[S3_ENV] rescue { :db => { :adapter => 'sqlite3', :database => "db/s3.db" } }
end

config
ActiveRecord::Base.establish_connection(@config[:db])
ActiveRecord::Base.include_root_in_json = false
#Bit.all.each do |u|
# puts u.to_json
#end

%w(bit bucket git_bucket slot user torrent torrent_peer).each do |c|
  puts "\"#{c}\":"
  puts eval(c.camelcase).all.to_json 
  #eval(c.camelcase).all.each do |r|
  #  puts r.to_json
  #end
end
