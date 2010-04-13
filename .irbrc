require 'pp'
require 'rubygems'
require 'wirble'

IRB.conf[:SAVE_HISTORY] = 100000 if RUBY_VERSION >= '1.9'

Wirble.init
Wirble.colorize
