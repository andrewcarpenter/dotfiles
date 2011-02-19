class TabCompleter
  require 'fileutils'
  
  @@instances = []
  
  attr_accessor :options
  
  def initialize(options)
    @options = options
    @@instances << self
  end
  
  def relevant?(line)
    line =~ options[:when]
  end
  
  def possible_options(line)
    if line =~ options[:when]
      current_command = $1
      
      if current_command.nil? || current_command.empty?
        all_options_with_caching
      else
        if options[:completion_separator]
          selected_options = all_options_with_caching.find_all{|opt| opt =~ /^#{current_command}/}
          separator = options[:completion_separator]
          if current_command =~ /^([-\w#{separator}]+#{separator})/
            upto_last_separator = $1
            selected_options.collect { |o| (o =~ /^#{Regexp.escape upto_last_separator}([-\w#{separator}]+)$/) ? $1 : o }
          else
            selected_options
          end
          
        else
          all_options_with_caching.find_all{|opt| opt =~ /^#{current_command}/}
        end
      end
    end
  end
  
  def all_options_with_caching
    if !cache_exists || cache_is_old
      cache_all_options
    else
      all_options_from_cache
    end
  end
  
  def cache_name
    @cache_name ||= if options[:cache_name].class == Proc
                      cache_name = options[:cache_name].call
                    else
                      cache_name = options[:cache_name]
                    end
  end
  
  def cache_dir
    @cache_dir ||= File.join( ENV['HOME'], '.bash', 'completion-cache' )
  end
  
  def cache_path
    @cache_path ||= File.join( cache_dir, cache_name )
  end
  
  def cache_exists
    File.exists?(cache_path)
  end
  
  def cache_is_old
    cache_age = File.mtime(cache_path)
    files_to_compare_to = if options[:expire_cache_if_older_than].class == Proc
                            options[:expire_cache_if_older_than].call()
                          else
                            options[:expire_cache_if_older_than].to_a
                          end
    
    files_to_compare_to.any?{|file| File.mtime(file) > cache_age}
  end
  
  def cache_all_options
    FileUtils.mkdir_p(cache_dir)
    File.open( cache_path, 'w' ) do |f| f << all_options.join("\n"); end
    all_options
  end
  
  def all_options_from_cache
    File.read( cache_path )
  end
  
  def all_options
    @all_options ||= if options[:with].class == Proc
                       options[:with].call
                     else
                       options[:with]
                     end
  end
  
  # CLASS METHODS
  def self.complete(current_line = ENV["COMP_LINE"])
    @@instances.each do |completer|
      if completer.relevant?(current_line)
        puts completer.possible_options(current_line)
        exit 0
      end
    end
    
    exit 0
  end
end