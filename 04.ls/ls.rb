#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'lib/ls_command'

option = ARGV.getopts('a').transform_keys(&:to_sym)
path = ARGV[0]

LsCommand.new(path, option).execute
