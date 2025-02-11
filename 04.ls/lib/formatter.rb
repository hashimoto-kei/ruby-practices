# frozen_string_literal: true

class Formatter
  MAX_COLUMNS = 3
  BLANK = nil

  def self.format(files)
    names = files.map(&:name)
    max_length = names.map(&:length).max
    names << BLANK until (names.size % MAX_COLUMNS).zero?
    row_size = names.size / MAX_COLUMNS
    rows = names.each_slice(row_size).to_a.transpose.map do |row|
      row = row.compact.map { |name| name.ljust(max_length) }
      row.join("\t")
    end
    rows.join("\n")
  end
end
