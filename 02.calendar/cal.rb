#!/usr/bin/env ruby
require 'date'
require 'optparse'

class Calendar
  def initialize(year, month)
    @year = year ? year.to_i : Date.today.year
    @month = month ? month.to_i : Date.today.month
  end

  def generate
    header = generate_header
    body = generate_body
    [*header, *body].join("\n")
  end

  private

  def generate_header
    first_row = "      #{@month}月 #{@year}"
    second_row = "日 月 火 水 木 金 土"
    [first_row, second_row]
  end

  def generate_body
    first_date = Date.new(@year, @month, 1)
    last_date = Date.new(@year, @month, -1)

    rows = (first_date..last_date).slice_when {|date| date.saturday?}
    first_row, *other_rows = rows.map do |row|
      row.map{|date| date.day.to_s.rjust(2)}.join(' ')
    end

    blank = "   " * first_date.wday
    [blank + first_row, *other_rows]
  end
end

option = {}
opt = OptionParser.new
opt.on('-m month') {|v| option[:m] = v}
opt.on('-y year') {|v| option[:y] = v}
opt.parse!(ARGV)

puts Calendar.new(option[:y], option[:m]).generate
