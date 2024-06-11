
class Game
  attr_accessor :finished
  def initialize **kwargs
    @finished = false
    @score = 0
  end

  def draw
    Text.new(text_message)
  end


  def add_score
    @score += 5
  end

  def finish
    @finished = true
  end

  private
    def text_message
      if finished
        "Game Over! Your was #{@score}. Press ENTER to restart"
      else
        "Score: #{@score}"
      end
    end
end