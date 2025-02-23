#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'lib/ls_command'

option = ARGV.getopts('a', 'r', 'l', symbolize_names: true)
path = ARGV[0]

LsCommand.new(path, option).execute
