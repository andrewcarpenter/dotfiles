#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), 'tab_completer')

TabCompleter.new(
  :cache_name => "ssh_aliases",
  :when => /^ssh\b\s*(\w+)?$/,
  :with => Proc.new do
    hosts = []
    File.open(File.expand_path("~/.ssh/config")).each do |line|
      if line =~ /^Host (\w+)/
        hosts << $1
      end
    end
    hosts
  end,
  :expire_cache_if_older_than => Proc.new {File.expand_path("~/.ssh/config")}
)

TabCompleter.complete
