#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), 'tab_completer')

TabCompleter.new(
  :cache_name => Proc.new { 'rake_commands_' + Dir.pwd.gsub('/', '_' ) },
  :when => /^rake\b\s*(\S+)?$/,
  :with => Proc.new do
    output = `rake -T`
    commands = output.scan(/^rake \S+/).map{|line| line.gsub(/^rake /,'')}
  end,
  :expire_cache_if_older_than => Proc.new {Dir["lib/tasks/*.rake"]},
  :completion_separator => ':'
)

TabCompleter.complete()
