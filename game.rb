
class Game
  GAME_STATES = [:playing, :paused, :finished ]
  # attr_accessor :finished
  def initialize **kwargs
    @state = GAME_STATES[0]
    @score = 0
  end

  def draw
    Text.new(text_message)
  end

  def add_score
    @score += 5
  end

  def finish
    puts "finish game"
    @state = :finished

  end

  GAME_STATES.each do |attr|
    define_method("is_#{attr.to_s}?") do
      @state == attr
    end

    define_method("set_#{attr.to_s}") do
      @state = attr
    end
  end

  private
    def text_message
      case
      when is_finished? then
        "Game Over! Your was #{@score}. Press ENTER to restart"
      when is_paused? then
        "Game is paused! Press Enter to return"
      else
        "Score: #{@score}"
      end
    end
end