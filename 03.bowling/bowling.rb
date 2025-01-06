#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './frame'
require_relative './last_frame'

class Bowling
  ALL_FRAMES = 10

  def initialize(scores)
    @frames = generate_frames(scores)
  end

  def total_score
    @frames.map(&:score).sum
  end

  private

  def generate_frames(scores)
    frame = Frame.new
    frames = [frame]
    scores.each do |score|
      frame.add(score)
      next unless frame.filled?
      break if frames.length == ALL_FRAMES

      final = (frames.length == ALL_FRAMES - 1)
      klass = final ? FinalFrame : Frame
      new_frame = klass.new
      frames << new_frame
      frame.next = new_frame
      frame = new_frame
    end
    frames
  end
end

score = ARGV[0]
scores = score.split(',')
puts Bowling.new(scores).total_score
