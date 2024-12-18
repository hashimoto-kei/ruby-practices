#!/usr/bin/env ruby
require 'date'
require 'optparse'

class Calendar
  def initialize(year, month)
    @year = year ? year.to_i : Date.today.year
    @month = month ? month.to_i : Date.today.month
    @first_date = Date.new(@year, @month, 1)
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
    blank = "   " * @first_date.wday
    days = generate_days
    [blank + days[0], *days[1..]]
  end

  def generate_days
    last_date = Date.new(@year, @month, -1)
    (@first_date..last_date).chunk_while do |date|
      !date.saturday?
    end.map do |dates|
      dates.map{|date| date.day.to_s.rjust(2)}.join(' ')
    end
  end
end

option = {}
opt = OptionParser.new
opt.on('-m month') {|v| option[:m] = v}
opt.on('-y year') {|v| option[:y] = v}
opt.parse!(ARGV)

puts Calendar.new(option[:y], option[:m]).generate
