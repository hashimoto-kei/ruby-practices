# frozen_string_literal: true

class Formatter
  MAX_COLUMNS = 3
  BLANK = nil

  def self.format(entries)
    file_names = entries.map(&:file_name)
    max_length = file_names.map(&:length).max
    file_names << BLANK until (file_names.size % MAX_COLUMNS).zero?
    row_size = file_names.size / MAX_COLUMNS
    rows = file_names.each_slice(row_size).to_a.transpose.map do |row|
      row = row.compact.map { |file_name| file_name.ljust(max_length) }
      row.join("\t")
    end
    rows.join("\n")
  end
end
