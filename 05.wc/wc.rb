#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'lib/wc_command'

options = ARGV.getopts('l', 'w', 'c', symbolize_names: true)
paths = ARGV
WcCommand.new(paths, options).execute
