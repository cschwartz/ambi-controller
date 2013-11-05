# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require 'faye'
Faye::WebSocket.load_adapter('thin')
bayeux = Faye::RackAdapter.new(:mount => "", :timeout => 25)
#run Rails.application
#run bayeux
run Rack::URLMap.new({
  '/' => Rails.application,
  '/faye' => bayeux
})
