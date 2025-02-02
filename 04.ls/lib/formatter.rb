#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'entry'

class Formatter
  MAX_COLUMNS = 3
  BLANK = Entry.new

  def self.format(entries)
    max_file_name_length = entries.map(&:file_name).map(&:length).max
    rows = ((entries.size - 1) / MAX_COLUMNS) + 1
    matrix = entries.each_slice(rows).to_a
    matrix[-1] << BLANK until matrix[-1].size % rows == 0
    matrix = matrix.map do |column|
      column.map(&:file_name).map{ |file_name| file_name.ljust(max_file_name_length) }
    end
    rows = matrix.transpose.map do |row|
      row.join("\t")
    end
    rows.join("\n")
  end
end
