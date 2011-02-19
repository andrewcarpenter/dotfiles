#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), 'tab_completer')

TabCompleter.new(
  :cache_name => "app_commands",
  :when => /^app\b\s*(\w+)?$/,
  :with => Proc.new do
    commands = ['apache_access_log', 'apache_error_log', 'log', 'mate', 'open', 'restart']
    Dir.entries('/etc/apache2/passenger_pane_vhosts/').each do |entry|
      if entry =~ /(\w+).local.vhost.conf/
        commands << $1
      end
    end
    commands
  end,
  :expire_cache_if_older_than => Proc.new{ Dir["/etc/apache2/passenger_pane_vhosts/*.local.vhost.conf"] }
)

TabCompleter.complete()