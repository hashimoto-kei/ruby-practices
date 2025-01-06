#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './frame'
require_relative './last_frame'

class Bowling
  ALL_FRAMES = 10

  def initialize(scores)
    shots = scores.map { |score| score == 'X' ? Frame::ALL_PINS : score.to_i }
    @frames = generate_frames(shots)
  end

  def total_score
    @frames.map(&:score).sum
  end

  private

  def generate_frames(shots)
    frame = Frame.new
    frames = [frame]
    shots.each do |shot|
      frame.add(shot)
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
