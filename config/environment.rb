require 'bundler/setup'
Bundler.require(:default)
$: << '.'

Dir["lib/*.rb"].each {|f| require f}
