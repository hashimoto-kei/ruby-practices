#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'lib/ls_command'

option = ARGV.getopts('a', 'r', 'l').transform_keys {|key| key.to_sym }
path = ARGV[0]

puts LsCommand.new(option, path).execute
