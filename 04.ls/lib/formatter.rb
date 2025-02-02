#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'entry'

class Formatter
  MAX_COLUMNS = 3
  BLANK = ''

  def self.format(entries)
    max_file_name_length = entries.map(&:file_name).map(&:length).max
    file_names = entries.map(&:file_name).map { |file_name| file_name.ljust(max_file_name_length) }
    file_names << BLANK until file_names.size % MAX_COLUMNS == 0
    rows = file_names.size / MAX_COLUMNS
    rows = file_names.each_slice(rows).to_a.transpose.map { |row| row.join("\t") }
    rows.join("\n")
  end
end
