#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'entry'

class LongFormatter
  def self.format(entries)
    max_nlink_digits = entries.map(&:nlink).max.digits.size
    max_size_digits = entries.map(&:size).max.digits.size
    rows = entries.map do |entry|
      row = "#{entry.file_type}#{entry.permissions}  #{entry.nlink.to_s.rjust(max_nlink_digits)} #{entry.user_name}  #{entry.group_name}  #{entry.size.to_s.rjust(max_size_digits)} #{entry.timestamp} #{entry.file_name}"
      entry.link_name.nil? ? row : "#{row} -> #{entry.link_name}"
    end
    total_blocks = entries.map(&:blocks).sum
    ["total #{total_blocks}", *rows].join("\n")
  end
end
