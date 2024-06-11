class Ball
  def initialize **kwargs
    set_ball kwargs[:screen_width], kwargs[:screen_height]
    @square_size = kwargs[:square_size]
  end

  def set_ball x, y
    @ball_x = rand(x)
    @ball_y = rand(y)
  end

  def draw
    Square.new(x: @ball_x * @square_size, y: @ball_y * @square_size, color: '#ae5a41', size: @square_size-1)
  end

  def hit_ball? x, y
    x == @ball_x && y == @ball_y
  end

end