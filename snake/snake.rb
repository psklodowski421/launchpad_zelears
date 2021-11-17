require 'gosu'
require 'unimidi'
require 'matrix'
require "midi-eye"
require 'pry'
$:.unshift(File.join("..", "lib"))
Dir["./*.rb"].each {|file| require file }



class Snake < Gosu::Window
  attr_accessor :table, :output, :x, :y, :memory, :dir, :fps, :body, :apple, :counter, :color, :appley, :applex, :apples, :status, :gameover, :lose, :done
  include Config
  include Control
  include GameRules
  include Connection
  def initialize
    connect
    super 8, 8
    initializers
  end

  def update
    if Gosu.button_down? Gosu::KB_F1
      @gameover =0
      @body =[[3,3],[3,4],[3,5]]
      @notes.each do |note|
        @output.puts(0x80,note,15)
      end
      @apples =0
      clear
    end
    def move
      def button_down(id)
        case id
        when Gosu::KB_ESCAPE
          notes.each do |note|
            @output.puts(0x80,note,15)
          end
          MainLauncher.new.show
        end
      end
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
         if @gameover ==0
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
    end
    def rip
      @bottom.each do |death|
        output.puts(0x90,table[*death],3)
      end
      @bottom_sides.each do |death|
        output.puts(0x90,table[*death],1)
      end
    end
  end

  def draw
    gamestate
  end
end
