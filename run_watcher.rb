#!/usr/bin/env ruby

require 'daemons'

Daemons.run('lib/watcher.rb')
