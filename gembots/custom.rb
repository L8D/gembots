module CustomRobot
  class Robot
    attr_accessor :name
    def initialize
      @name = "Robot"
      @x_pos = 0
      @y_pos = 0
      @angle = 0
    end
    
    def x_pos
      return @x_pos
    end

    def y_pos
      return @y_pos
    end

    def angle
      return @angle
    end

    def new
      self.initialize
      return self
    end

    # rotates clockwise the degrees specified
    # use negative numbers to turn counter clockwise
    def turn degrees=1
      @angle += degrees
      @angle -= 8 if @angle > 7
      @angle += 8 if @angle < 0
    end

    # moves forward the distance specified
    # use negative numbers to move in reverse
    def move distance
      case @angle
        when 0 then
          @y_pos += distance

        when 1 then
          @y_pos += distance
          @x_pos += distance

        when 2 then
          @x_pos += distance

        when 3 then
          @x_pos += distance
          @y_pos -= distance

        when 4 then
          @y_pos -= distance

        when 5 then
          @y_pos -= distance
          @x_pos -= distance

        when 6 then
          @x_pos -= distance

        when 7 then
          @x_pos -= distance
          @y_pos += distance
        else
          puts "Angle is not between 0 and 7!"
          exit
      end
      # wrap around arena if position moves out of bounds
      @y_pos -= 21 if @y_pos > 10 or @y_pos < -10
      @x_pos -= 21 if @x_pos > 10 or @x_pos < -10
    end
  end
end
