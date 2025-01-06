# frozen_string_literal: true

class FinalFrame < Frame
  BONUS_ROLL = 1

  def score
    @shots.sum
  end

  def filled?
    bonus = (strike? || spare? ? BONUS_ROLL : 0)
    rolls == MAX_ROLLS + bonus
  end
end
