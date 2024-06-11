require 'ruby2d'
require './snake.rb'
require './game.rb'
require './ball.rb'

# Define a square shape.

class Match
  require 'ruby2d'

  SQUARE_SIZE=20
  SCREEN_WIDTH = Window.width / SQUARE_SIZE
  SCREEN_HEIGHT = Window.height / SQUARE_SIZE


  def start_game
    @snake = Snake.new(square_size: SQUARE_SIZE, screen_width: SCREEN_WIDTH, screen_height: SCREEN_HEIGHT)
    @game = Game.new(square_size: SQUARE_SIZE, screen_width: SCREEN_WIDTH, screen_height: SCREEN_HEIGHT)
    @ball = Ball.new(square_size: SQUARE_SIZE, screen_width: SCREEN_WIDTH, screen_height: SCREEN_HEIGHT)
  end

  def screen_params
    Ruby2D::Window.set background: '#b8d8be', title: 'SNAKE'
    Ruby2D::Window.set fps_cap: 20
  end

  def match
    screen_params
    start_game

    Ruby2D::Window.update do
      # Att all events on screen
      att_screen
      # Get colision with itself and the ball
      match_colisions
    end

    # Validate inputs
    key_event_validation
    # Print o window
    Ruby2D::Window.show
  end

  def att_screen
    Ruby2D::Window.clear
    unless @game.finished
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
      @game.finish
    end
  end

  def key_event_validation
    Ruby2D::Window.on :key_down do |event|
      @snake.set_direction event.key if Snake::DIRECTIONS.include? event.key
      start_game if event.key == 'return' && @game.finished
    end
  end
end

snake_game = Match.new
snake_game.match