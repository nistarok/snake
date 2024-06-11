class Snake
  # DEFAULT
  # @square_size=20
  X_POSITION= 10
  Y_POSITION= 10
  X_INDEX = true

  DIRECTIONS=['up', 'down', 'left', 'right']

  X_MOVEMENT={'down' => 0, 'up' => 0, 'left' =>-1, 'right' =>+1}
  Y_MOVEMENT={'down' => 1, 'up' => -1, 'left' =>0, 'right' =>0}

  FORBIDDEN_MOVEMENT={'down' => 'up', 'up' => 'down', 'left' =>'right', 'right' =>'left'}

  attr_writer :direction

  def initialize **kwargs
    @tail = []
    @square_size = kwargs[:square_size]
    @screen_width = kwargs[:screen_width]
    @screen_height = kwargs[:screen_height]

    @direction = X_INDEX ? 'right' : 'down'

    4.times do |index|
      @tail.push [(X_INDEX ? index : 0) + X_POSITION, (X_INDEX ? 0 : index) + Y_POSITION]
    end
  end

  def draw
    @tail.each do |t|
      Square.new(x: t[0]*@square_size, y: t[1]*@square_size , color: '#5a5255', size: @square_size-1)
    end
  end

  def move
    @tail.shift unless @growing
    @tail.push(set_position(x_direction, y_direction))
    @growing = false
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
    @growing = true
  end

  def auto_hit?
    @tail.uniq.length != @tail.length
  end


  private
    def head
      @tail.last
    end

    def can_change_direction? new_dir
      return !(FORBIDDEN_MOVEMENT[new_dir] == @direction)
    end

    def set_position x, y
      [x % @screen_width, y % @screen_height]
    end

    #TODO METAPROGRAMAÇÂO NESSAS DUAS FUNÇÕES
    def x_direction
      head[0]+X_MOVEMENT[@direction]
    end

    def y_direction
      head[1]+Y_MOVEMENT[@direction]
    end

end