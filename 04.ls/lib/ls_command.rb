#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'entry'

class LsCommand
  MAX_COLUMNS = 3
  BLANK = Entry.new

  def initialize(path, option)
    @path = path.nil? ? '.' : path
    @option = option
  end

  def execute
    entries = create_entries
    columns = (@option[:l] ? 1 : MAX_COLUMNS)
    rows = (entries.size - 1) / columns + 1
    matrix = entries.slice_when { |entry| entry.order % rows == 0 }
    matrix = matrix.to_a
    matrix[-1] << BLANK until matrix[-1].size % rows == 0
    digits = entries.map(&:nlink).max.digits.size
    size = entries.map(&:size).max.digits.size
    rows = matrix.transpose.map do |row|
      infos = row.map { |entry| entry.to_s(@option[:l], digits, size) }
      infos = infos.map {|info| info.ljust(10) }
      infos.join("\t")
    end
    #total = entries.filter { |entry| entry.path !~ /^\..*/ }.map(&:size).sum / 512
    total = entries.map(&:blocks).sum
    rows = ["total #{total}", *rows] if @option[:l]
    rows.join("\n")
  end

  def create_entries
    entries = Dir.entries(File.expand_path(@path)).sort
    entries.filter! { |entry| entry !~ /^\..*/ } unless @option[:a]
    entries.reverse! if @option[:r]
    entries = entries.map.with_index(1) { |path, order| Entry.new(path, order) }
    entries.to_a
  end
end
