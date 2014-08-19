require 'rubygems'
require 'bundler/setup'

require 'httparty'
require 'json'
require 'rss'

autoload_paths = %w(/lib)

autoload_paths.each do |path|
  file_path = File.join(File.dirname(__FILE__), "..", path)
  $LOAD_PATH.unshift(file_path)
  Dir["#{file_path}/**/*.rb"].each do |file|
    basename = File.basename(file, ".rb")
    require file
  end
end
