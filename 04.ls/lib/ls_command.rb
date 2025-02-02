#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'entry'
require_relative 'formatter'
require_relative 'long_formatter'

class LsCommand
  def initialize(option, path)
    path ||= '.'
    @path = File.expand_path(path)
    @option = option
  end

  def execute
    entries = create_entries
    formatter = (@option[:l] ? LongFormatter : Formatter)
    formatter.format(entries)
  end

  def create_entries
    entries = Dir.entries(@path).sort
    entries.filter! { |entry| entry !~ /^\..*/ } unless @option[:a]
    entries.reverse! if @option[:r]
    entries = entries.map { |file_name| Entry.new("#{@path}/#{file_name}", @option[:l]) }
    entries.to_a
  end
end
