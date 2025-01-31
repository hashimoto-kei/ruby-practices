#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'etc'
require 'optparse'

class Entry
  def initialize(path='', order=nil)
    @path = path
    @order = order
  end

  def to_s(l_option, digits)
    if !l_option
      @path
    else
      stat = File.lstat(@path)
      file_type = to_file_type(stat.ftype)
      mode = stat.mode.to_s(8).rjust(6, '0')
      permissions = to_permissions(mode[-3..-1])
      user_name = Etc.getpwuid(stat.uid).name
      group_name = Etc.getgrgid(stat.gid).name
      timestamp = to_timestamp(stat.mtime)
      symbolic_link = " -> #{File.readlink(@path)}" if file_type == 'l'
      "#{file_type}#{permissions}  #{stat.nlink.to_s.rjust(digits)} #{user_name}  #{group_name}  #{stat.size.to_s.rjust(4)} #{timestamp} #{@path}#{symbolic_link}"
    end
  end

  def path
    @path
  end

  def order
    @order
  end

  def blocks
    File.lstat(@path).blocks
  end

  def nlink
    File.lstat(@path).nlink
  end

  private

  def to_permissions(octats)
    permissions = octats.chars.map { |octat| to_permission(octat) }
    permissions.join
  end

  def to_permission(octat)
    permissions = octat.to_i.to_s(2).chars.map.with_index do |digit, i|
      case i
      when 0
        digit == '1' ? 'r' : '-'
      when 1
        digit == '1' ? 'w' : '-'
      when 2
        digit == '1' ? 'x' : '-'
      end
    end
    permissions.join
  end

  def to_file_type(ftype)
    case ftype
    when 'fifo'
      'p'
    when 'characterSpecial'
      'c'
    when 'directory'
      'd'
    when 'blockSpecial'
      'b'
    when 'file'
      '-'
    when 'link'
      'l'
    when 'socket'
      's'
    end
  end

  def to_timestamp(mtime)
    mtime.to_s.gsub(/(\d{4})-(\d)(\d)-(\d{2}) (\d{2}:\d{2}).*/) do
      day = ($2 == '0' ? " #{$3}" : "#{$2}#{$3}")
      if $1 == Date.today.year.to_s
        "#{day} #{$4} #{$5}"
      else
        "#{day} #{$4} #{$1}"
      end
    end
  end
end

class LsCommand
  MAX_COLUMNS = 3
  BLANK = Entry.new

  def initialize(path, option)
    @path = path.nil? ? '.' : path
    @option = option
  end

  def execute
    entries = create_entries
    columns = (@option[:l] ? 1 : MAX_COLUMNS)
    rows = (entries.size - 1) / columns + 1
    matrix = entries.slice_when { |entry| entry.order % rows == 0 }
    matrix = matrix.to_a
    matrix[-1] << BLANK until matrix[-1].size % rows == 0
    digits = entries.map(&:nlink).max.digits.size
    rows = matrix.transpose.map do |row|
      infos = row.map { |entry| entry.to_s(@option[:l], digits) }
      infos = infos.map {|info| info.ljust(10) }
      infos.join("\t")
    end
    #total = entries.filter { |entry| entry.path !~ /^\..*/ }.map(&:size).sum / 512
    total = entries.map(&:blocks).sum
    rows = ["total #{total}", *rows] if @option[:l]
    rows.join("\n")
  end

  def create_entries
    entries = Dir.entries(File.expand_path(@path)).sort
    entries.filter! { |entry| entry !~ /^\..*/ } unless @option[:a]
    entries.reverse! if @option[:r]
    entries = entries.map.with_index(1) { |path, order| Entry.new(path, order) }
    entries.to_a
  end
end

option = Hash.new(false)
opt = OptionParser.new
opt.on('-a') { option[:a] = true }
opt.on('-r') { option[:r] = true }
opt.on('-l') { option[:l] = true }
opt.parse!(ARGV)
path = ARGV[0]

puts LsCommand.new(path, option).execute
