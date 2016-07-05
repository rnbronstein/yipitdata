require 'bundler/setup'
Bundler.require(:default, :development)
$: << '.'

Dir["lib/*.rb"].each {|f| require f}


require "open-uri"
require "json"
