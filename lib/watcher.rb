#!/usr/bin/env ruby

require 'eventmachine'
require 'faye'

EventMachine.kqueue = true if EventMachine.kqueue?

EM.run {
  client = Faye::Client.new('http://192.168.2.115/faye', timeout: 3600, retry: 5)

  client.subscribe('/ambi-tv')

  class CurrentProgramHandler < EventMachine::FileWatch
    def initialize(client)
      @client = client
    end

    def file_modified
      current_program = File.open(path).read.strip
      @client.publish('/ambi-tv', 'current_program' => current_program)
    end
  end

  class PauseHandler < EventMachine::FileWatch
    def initialize(client)
      @client = client
    end

    def file_modified
      is_paused = File.open(path).read.strip
      @client.publish('/ambi-tv', 'is_paused' => is_paused)
    end
  end

  EventMachine.watch_file("/var/ambi-tv/status/current_program", CurrentProgramHandler, client)
  EventMachine.watch_file("/var/ambi-tv/status/is_paused", PauseHandler, client)
}
