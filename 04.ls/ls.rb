#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/ls_command'

path = ARGV[0]

LsCommand.new(path).execute
