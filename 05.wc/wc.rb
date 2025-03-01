#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/wc_command'

paths = ARGV
WcCommand.new(paths).execute
