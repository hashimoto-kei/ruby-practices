#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'etc'
require 'optparse'
require_relative 'lib/ls_command'

option = Hash.new(false)
opt = OptionParser.new
opt.on('-a') { option[:a] = true }
opt.on('-r') { option[:r] = true }
opt.on('-l') { option[:l] = true }
opt.parse!(ARGV)
path = ARGV[0]

puts LsCommand.new(path, option).execute
