# frozen_string_literal: true

class LOptionFormatter
  SECONDS_IN_HALF_YEAR = (365 / 2) * 24 * 60 * 60

  class << self
    def format(ls_files)
      header = generate_header(ls_files)
      body = generate_body(ls_files)
      [header, *body].join("\n")
    end

    private

    def generate_header(ls_files)
      total_blocks = ls_files.map(&:blocks).sum
      "total #{total_blocks}"
    end

    def generate_body(ls_files)
      now = Time.now
      max_widths = calculate_max_widths(ls_files, now)
      ls_files.map do |ls_file|
        formatted_file_name = format_file_name(ls_file.name, ls_file.link_name)
        formatted_timestamp = format_timestamp(ls_file.timestamp, now)
        "#{ls_file.type}#{ls_file.mode}" \
        "  #{ls_file.hard_links.to_s.rjust(max_widths[:hard_links])}" \
        " #{ls_file.owner_name.ljust(max_widths[:owner_name])}" \
        "  #{ls_file.group_name.ljust(max_widths[:group_name])}" \
        "  #{ls_file.size.to_s.rjust(max_widths[:size])}" \
        " #{formatted_timestamp[:date]}" \
        " #{formatted_timestamp[:time].rjust(max_widths[:time])}" \
        " #{formatted_file_name}"
      end
    end

    def calculate_max_widths(ls_files, now)
      max_widths = Hash.new(0)
      ls_files.each do |ls_file|
        widths = {
          hard_links: ls_file.hard_links.to_s.length,
          owner_name: ls_file.owner_name.length,
          group_name: ls_file.group_name.length,
          size: ls_file.size.to_s.length,
          time: format_timestamp(ls_file.timestamp, now)[:time].length
        }
        widths.each_key { |key| max_widths[key] = widths[key] if max_widths[key] < widths[key] }
      end
      max_widths
    end

    def format_timestamp(timestamp, now)
      timestamp.to_s.match(/(\d{4})-(\d{2})-(\d{2}) (\d{2}:\d{2}).*/) do
        year = Regexp.last_match(1)
        month = Regexp.last_match(2)
        day = Regexp.last_match(3)
        time = Regexp.last_match(4)
        {
          date: "#{month.to_i.to_s.rjust(2)} #{day.to_i.to_s.rjust(2)}",
          time: now - timestamp > SECONDS_IN_HALF_YEAR ? year : time
        }
      end
    end

    def format_file_name(file_name, link_name)
      link_name.nil? ? file_name : "#{file_name} -> #{link_name}"
    end
  end
end
