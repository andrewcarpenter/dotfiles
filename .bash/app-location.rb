#!/usr/bin/env ruby

app = ARGV.first

directory = ''
filename = "/etc/apache2/passenger_pane_vhosts/#{app}.local.vhost.conf"
if File.exists?(filename)
  File.open(filename).each do |line|
    if line =~ /DocumentRoot "(.*?)\/public"/
      directory = $1
    end
  end
end

puts directory