class Snake
  # DEFAULT
  # square_size=20
  DIRECTIONS=['up', 'down', 'left', 'right']
  X_MOVEMENT={'down' => 0, 'up' => 0, 'left' =>-1, 'right' =>+1}
  Y_MOVEMENT={'down' => 1, 'up' => -1, 'left' =>0, 'right' =>0}
  FORBIDDEN_MOVEMENT={'down' => 'up', 'up' => 'down', 'left' =>'right', 'right' =>'left'}

  attr_accessor :direction,
                :square_size,
                :screen_width,
                :screen_height,
                :x_index,
                :x_start_position,
                :y_start_position,
                :body,
                :growing

  def initialize **kwargs
    self.growing = false
    self.body = []
    self.square_size = kwargs[:square_size]
    self.screen_width = kwargs[:screen_width]
    self.screen_height = kwargs[:screen_height]
    self.x_index = kwargs[:x_index] || true
    self.x_start_position = kwargs[:x_start_position] || rand(screen_width)
    self.y_start_position = kwargs[:y_start_position] || rand(screen_height)

    self.direction = x_index ? 'right' : 'down'

    4.times do |index|
      self.body.push [(x_index ? index : 0) + x_start_position, (x_index ? 0 : index) + y_start_position]
    end
  end

  def draw
    self.body.each do |t|
      Square.new(x: t[0]*square_size, y: t[1]*square_size , color: '#5a5255', size: square_size-1)
    end
  end

  def move
    self.body.shift unless growing
    self.body.push(set_position(x_direction, y_direction))
    self.growing = false
    true
  end

  def set_direction new_dir
    return unless can_change_direction? new_dir
    self.direction = new_dir
  end

  def x
    head[0]
  end

  def y
    head[1]
  end

  def grow
    self.growing = true
  end

  def auto_hit?
    self.body.uniq.length != self.body.length
  end


  private
    def head
      self.body.last
    end

    def can_change_direction? new_dir
      return !(FORBIDDEN_MOVEMENT[new_dir] == direction)
    end

    def set_position x, y
      [x % screen_width, y % screen_height]
    end

    #TODO METAPROGRAMAÇÂO NESSAS DUAS FUNÇÕES
    def x_direction
      head[0]+X_MOVEMENT[direction]
    end

    def y_direction
      head[1]+Y_MOVEMENT[direction]
    end

end