#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'entry'

class LongFormatter
  def self.format(entries)
    max_nlink_digits = entries.map(&:nlink).max.digits.size
    max_size_digits = entries.map(&:size).max.digits.size
    rows = entries.map do |entry|
      "#{entry.file_type}#{entry.permissions}  #{entry.nlink.to_s.rjust(max_nlink_digits)} #{entry.user_name}  #{entry.group_name}  #{entry.size.to_s.rjust(max_size_digits)} #{entry.timestamp} #{entry.file_name}#{entry.symbolic_link}"
    end
    total = entries.map(&:blocks).sum
    rows = ["total #{total}", *rows]
    rows.join("\n")
  end
end
