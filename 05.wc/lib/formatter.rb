# frozen_string_literal: true

class Formatter
  WIDTH = 7

  class << self
    def format(wc_files)
      total_counts = Hash.new(0)
      body = wc_files.map do |wc_file|
        counts = {
          lines: wc_file.count_lines,
          words: wc_file.count_words,
          characters: wc_file.count_characters
        }
        counts.each_key { |key| total_counts[key] += counts[key] }
        generate_row(counts, wc_file.path)
      end
      footer = generate_row(total_counts, 'total') if wc_files.size > 1
      [*body, footer].join("\n")
    end

    private

    def generate_row(counts, file_path)
      cols = []
      cols << " #{counts[:lines].to_s.rjust(WIDTH)}"
      cols << counts[:words].to_s.rjust(WIDTH)
      cols << counts[:characters].to_s.rjust(WIDTH)
      cols << file_path
      cols.join(' ')
    end
  end
end
