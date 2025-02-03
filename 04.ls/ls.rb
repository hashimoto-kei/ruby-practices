#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'lib/ls_command'

path = ARGV[0]

puts LsCommand.new(path).generate
