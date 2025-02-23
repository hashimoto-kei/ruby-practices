# frozen_string_literal: true

require 'etc'

class LsFile
  FTYPE_TO_TYPE = {
    fifo: 'p',
    characterSpecial: 'c',
    directory: 'd',
    blockSpecial: 'b',
    file: '-',
    link: 'l',
    socket: 's'
  }.freeze

  attr_reader :name, :type, :mode, :hard_links, :owner_name, :group_name, :size, :timestamp, :link_name, :blocks

  def initialize(path)
    @name = File.basename(path)
    stat = File.lstat(path)
    @type = FTYPE_TO_TYPE[stat.ftype.to_sym]
    @mode = symbolize_mode(stat.mode.to_s(8)[-3..])
    @hard_links = stat.nlink
    @owner_name = Etc.getpwuid(stat.uid).name
    @group_name = Etc.getgrgid(stat.gid).name
    @size = stat.size
    @timestamp = stat.mtime
    @link_name = File.readlink(path) if File.symlink?(path)
    @blocks = stat.blocks
  end

  def hidden?
    @name.start_with?('.')
  end

  private

  def symbolize_mode(absolute_mode)
    absolute_mode
      .chars
      .map { |octal_permission| symbolize_octal_permission(octal_permission) }
      .join
  end

  def symbolize_octal_permission(octal_permission)
    octal_permission
      .to_i
      .to_s(2)
      .rjust(3, '0')
      .chars
      .map
      .with_index { |digit, index| digit == '1' ? 'rwx'[index] : '-' }
      .join
  end
end
