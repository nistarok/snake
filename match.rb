require 'ruby2d'
require './snake.rb'
require './game.rb'
require './ball.rb'

# Define a square shape.

class Match
  require 'ruby2d'

  SQUARE_SIZE = 20
  SCREEN_WIDTH = Window.width / SQUARE_SIZE
  SCREEN_HEIGHT = Window.height / SQUARE_SIZE

  def start_game
    if @game.nil? || @game.is_finished?
      @snake = Snake.new(square_size: SQUARE_SIZE, screen_width: SCREEN_WIDTH, screen_height: SCREEN_HEIGHT)
      @game = Game.new
      @ball = Ball.new(square_size: SQUARE_SIZE, screen_width: SCREEN_WIDTH, screen_height: SCREEN_HEIGHT)
    end
  end

  def pause_match
    @game.set_paused if @game.is_playing?
  end


  def change_match_state
    !!@game && @game.is_paused? ? @game.set_playing : start_game
  end

  def screen_params
    Ruby2D::Window.set background: '#b8d8be', title: 'SNAKE'
    Ruby2D::Window.set fps_cap: 20

    Text.new("Press ENTER to start the game") if @game.nil?
  end

  def match
    screen_params
    # start_game

    Ruby2D::Window.update do
      # Att all events on screen
      if !!@game
        att_screen
        # Get colision with itself and the ball
        match_colisions
      end
    end

    # Validate inputs
    key_event_validation
    # Print window
    Ruby2D::Window.show
  end

  def att_screen
    Ruby2D::Window.clear
    unless @game.is_finished? || @game.is_paused?
      @snake.move
      @ball.draw
    end

    @snake.draw
    @game.draw
  end

  def match_colisions
    if @ball.hit_ball?(@snake.x, @snake.y)
      @snake.grow
      @snake.draw
      @game.add_score
      @ball.set_ball SCREEN_WIDTH, SCREEN_HEIGHT
    end

    if @snake.auto_hit?
      @game.set_finished
    end
  end

  def key_event_validation
    Ruby2D::Window.on :key_down do |event|
      case
      when Snake::DIRECTIONS.include?(event.key) then
        @snake.set_direction event.key
      when event.key == 'return' then
        change_match_state if event.key == 'return'
      when event.key == 'p' then
        pause_match
      end
    end
  end
end

snake_game = Match.new
snake_game.match