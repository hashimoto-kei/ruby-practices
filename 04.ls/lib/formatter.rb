# frozen_string_literal: true

class Formatter
  MAX_COLUMNS = 3

  def self.format(ls_files)
    names = ls_files.map(&:name)
    max_length = names.map(&:length).max
    blanks = (MAX_COLUMNS - names.size) % MAX_COLUMNS
    names.push(*Array.new(blanks))
    row_size = names.size / MAX_COLUMNS
    rows = names.each_slice(row_size).to_a.transpose.map do |row|
      row.compact.map { |name| name.ljust(max_length) }.join("\t")
    end
    rows.join("\n")
  end
end
