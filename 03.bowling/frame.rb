class Frame
  ALL_PINS = 10
  MAX_ROLLS = 2

  attr_accessor :next

  def initialize
    @shots = []
  end

  def add(shot)
    @shots << shot
  end

  def score
    @shots.sum + bonus_pins
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

  def bonus_pins
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
