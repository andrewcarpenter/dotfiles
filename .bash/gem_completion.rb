#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), 'tab_completer')

TabCompleter.new(
  :cache_name => "gem_commands",
  :when => /^gem\b\s*(\w+)?$/,
  :with => Proc.new do
    output = `gem help command`
    commands = output.scan(/^    \w+/).map(&:lstrip)
  end,
  :expire_cache_if_older_than => '/usr/local/lib/ruby/gems/1.8/cache'
)

TabCompleter.new(
  :cache_name => "gem_names",
  :when => /^gem\s+\w+\s+(\S*)/,
  :with => Proc.new do
    gem_names = `gem list`
    gem_names.scan(/^[A-Za-z0-9_-]+/)
  end,
  :expire_cache_if_older_than => '/usr/local/lib/ruby/gems/1.8/cache'
)

TabCompleter.complete