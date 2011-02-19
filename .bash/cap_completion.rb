#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), 'tab_completer')

TabCompleter.new(
  :cache_name => Proc.new { 'cap_commands_' + Dir.pwd.gsub('/', '_' ) },
  :when => /^cap\b\s*(\S+)?$/,
  :with => Proc.new do
    output = `cap --quiet --tasks`
    commands = output.scan(/^cap \S+/).map{|line| line.gsub(/^cap /,'')}
  end,
  :expire_cache_if_older_than => 'config/deploy.rb',
  :completion_separator => ':'
)

TabCompleter.complete()
