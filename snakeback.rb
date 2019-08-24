require 'gosu'
require 'unimidi'
require 'matrix'
require "midi-eye"
require 'pry'
$:.unshift(File.join("..", "lib"))

class Snake < Gosu::Window
  attr_accessor :table, :output, :x, :y, :memory, :dir, :fps, :body, :apple, :counter, :color, :appley, :applex, :apples, :status, :gameover, :lose, :done
  def initialize
    super 8, 8
    @done = 0
    @status = 0
    @gameover = 0
    @fps = 0
    @output = UniMIDI::Output.gets
    @table=Matrix[
      [337,338,339,340,341,342,343,344],
      [327,328,329,330,331,332,333,334],
      [317,318,319,320,321,322,323,324],
      [307,308,309,310,311,312,313,314],
      [297,298,299,300,301,302,303,304],
      [287,288,289,290,291,292,293,294],
      [277,278,279,280,281,282,283,284],
      [267,268,269,270,271,272,273,274]]
    @lose=[[7,3],[7,4],[6,3],[6,4],[5,3],[5,4],[4,3],[4,4],[2,3],[2,4]]
    @notes=
    [267,268,269,270,271,272,273,274,
     277,278,279,280,281,282,283,284,
     287,288,289,290,291,292,293,294,
     297,298,299,300,301,302,303,304,
     307,308,309,310,311,312,313,314,
     317,318,319,320,321,322,323,324,
     327,328,329,330,331,332,333,334,
     337,338,339,340,341,342,343,344]
     @x = 5
     @y = 3
     @body =[[3,3],[3,4],[3,5]]
     @dir = 3
     @color = 66
     @memory=table[@y,@x]
     @head =[@y,@x]
     @notes.each do |note|
       @output.puts(0x80,note,15)
     end
     @body.each do |array|
       output.puts(0x90,table[*array],@color)
     end
     @apple =[@appley=rand(0..7),@applex=rand(0..7)]
     @output.puts(0x90,table[@appley,@applex],120)
  end


  def update
    if Gosu.button_down? Gosu::KB_F1
      @gameover =0
      @body =[[3,3],[3,4],[3,5]]
      @notes.each do |note|
        @output.puts(0x80,note,15)
      end
      @apples =0

    end
    def move
      if Gosu.button_down? Gosu::KB_LEFT
        if @dir != 3
        @dir = 4
      end

      elsif Gosu.button_down? Gosu::KB_RIGHT
        if @dir != 4
        @dir = 3
      end

      elsif Gosu.button_down? Gosu::KB_UP
        if @dir !=2
        @dir = 1
      end

      elsif Gosu.button_down? Gosu::KB_DOWN
        if @dir !=1
        @dir = 2
       end
      end
      if @apples == 0
        @apple =[@appley=rand(0..7),@applex=rand(0..7)]
        @body.each do |check|
          if  [*check] == [*@apple]
            @status +=1
          end
        end
        if @status ==0
        @apples = 1
        @output.puts(0x90,table[*@apple],120)
        end
      end
      @status=0
      @fps +=1
       if @fps % 10 ==0
         if @y == @appley && @x == @applex
           @counter =0
           @apples =0
           else
             @counter =1
         end
        if @dir == 1 #UP arrow
          @y -=1
          if @y < 0
            @y = 7
          end
          if @counter==1
          memory_shift= @body.shift
          output.puts(0x80,table[*memory_shift],@color)
        end
          output.puts(0x90,@memory=table[@y,@x],@color)
          @head =[@y,@x]
          @body.each do |checks|
            if [*checks] == @head
              @gameover = 1
            end
          end
          memory_push = @body.push [@y,@x]
        end

        if @dir == 2 #DOWN arrow
          @y +=1
          if @y > 7
            @y =0
          end
                    if @counter==1
                      memory_shift= @body.shift
          output.puts(0x80,table[*memory_shift],@color)
        end
          output.puts(0x90,@memory=table[@y,@x],@color)
          @head =[@y,@x]
          @body.each do |checks|
            if [*checks] == @head
              @gameover = 1
            end
          end
          memory_push = @body.push [@y,@x]
        end

        if @dir == 3 #RIGHT arrow
          @x +=1
          if @x > 7
            @x =0
          end
                    if @counter==1
                      memory_shift= @body.shift
          output.puts(0x80,table[*memory_shift],@color)
        end
          output.puts(0x90,@memory=table[@y,@x],@color)
          @head =[@y,@x]
          @body.each do |checks|
            if [*checks] == @head
              @gameover = 1
            end
          end
          memory_push = @body.push [@y,@x]
        end

        if @dir == 4 #LEFT arrow
          @x -=1
          if @x < 0
            @x =7
          end
                    if @counter==1
                      memory_shift= @body.shift
          output.puts(0x80,table[*memory_shift],@color)
        end
          output.puts(0x90,@memory=table[@y,@x],@color)
          @head =[@y,@x]
          @body.each do |checks|
            if [*checks] == @head
              @gameover = 1
            end
          end
          memory_push = @body.push [@y,@x]
        end
      end
    end
    def rip

      if @done == 0
      @notes.each do |note|
        @output.puts(0x80,note,15)
        @done=1
      end
    end
      @lose.each do |death|
        output.puts(0x90,table[*death],90)
      end
    end
  end

  def draw
    if gameover == 0
    move
    end
    if gameover == 1
      rip
    end
  end
end

Snake.new.show
