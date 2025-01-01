#!/usr/bin/env ruby
# frozen_string_literal: true

ALL_PINS = 10
ALL_FRAMES = 10
MAX_ROLLS = 2

class Frame
  attr_accessor :next

  def initialize
    @shots = []
  end

  def <<(shot)
    @shots << shot
  end

  def score
    @shots.sum + bonus
  end

  def filled?
    strike? || rolls == MAX_ROLLS
  end

  def first_shot
    @shots[0].to_i
  end

  def second_shot
    @shots[1].to_i
  end

  def rolls
    @shots.length
  end

  private

  def strike?
    first_shot == ALL_PINS
  end

  def spare?
    !strike? && (first_shot + second_shot == ALL_PINS)
  end

  def bonus
    if strike?
      next_two_shots.sum
    elsif spare?
      @next.first_shot
    else
      0
    end
  end

  def next_two_shots
    first_shot = @next.first_shot
    second_shot = (@next.rolls == 1 ? @next.next.first_shot : @next.second_shot)
    [first_shot, second_shot]
  end
end

class FinalFrame < Frame
  def score
    @shots.sum
  end

  def filled?
    if strike? || spare?
      rolls == MAX_ROLLS + 1
    else
      rolls == MAX_ROLLS
    end
  end
end

class Bowling
  def initialize(scores)
    @scores = scores
  end

  def total_score
    shots = @scores.map { |score| score == 'X' ? ALL_PINS : score.to_i }
    frames = to_frames(shots)
    frames.map(&:score).sum
  end

  private

  def to_frames(shots)
    frames = []
    frame = Frame.new
    shots.each do |shot|
      frame << shot
      next unless frame.filled?

      frames << frame
      final = (frames.length == ALL_FRAMES - 1)
      clazz = final ? FinalFrame : Frame
      new_frame = clazz.new
      frame.next = new_frame
      frame = new_frame
    end
    frames
  end
end

score = ARGV[0]
scores = score.split(',')
puts Bowling.new(scores).total_score
