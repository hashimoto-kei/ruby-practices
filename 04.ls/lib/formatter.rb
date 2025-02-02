#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'entry'

class Formatter
  MAX_COLUMNS = 3
  BLANK = ''

  def self.format(entries)
    max_file_name_length = entries.map(&:file_name).map(&:length).max
    file_names = entries.map(&:file_name).map { |file_name| file_name.ljust(max_file_name_length) }
    rows = ((file_names.size - 1) / MAX_COLUMNS) + 1
    matrix = file_names.each_slice(rows).to_a
    matrix[-1] << BLANK until matrix[-1].size % rows == 0
    rows = matrix.transpose.map { |row| row.join("\t") }
    rows.join("\n")
  end
end
