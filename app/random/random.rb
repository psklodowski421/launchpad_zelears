require 'gosu'
require 'unimidi'
require 'matrix'
require "midi-eye"
require 'pry'
$:.unshift(File.join("..", "lib"))
Dir["./*.rb"].each {|file| require file }

class Sleeper < Gosu::Window
  attr_accessor :esc, :speed , :text, :timer
  include Config
  include Control
  include Gamerules
  include Connection

  def initialize
    super 600, 600
    self.caption = "Fun Light"
    @esc = 0
    @speed = 5
    connect
    @font = Gosu::Font.new(20)
    @timer = 0
    @dots = 1

  end

  def button_down(id)
    case id
    when Gosu::KB_UP
      @dots += 1
    when Gosu::KB_DOWN
      @dots -= 1
    when Gosu::KB_RIGHT
      @speed += 1
    when Gosu::KB_LEFT
      @speed -= 1
    when Gosu::KB_ESCAPE
      @esc = 1
      notes.each do |note|
        @output.puts(0x80,note,15)
      end
      Welcome.new.show
      close
    end
  end

  def teksty
    text.draw
  end

  def kolorek
    output.puts(0x90,notes.sample,rand(1..120))
  end

  def coolspeed
    (-1*@speed)+11
  end

  def update
  end

  def draw
    @font.draw_text("Speed: #{speed}", 250, 250, 10, 1, 1, color = 0xff_44ffff)
    @font.draw_text("Number of dots changes in cycle: #{@dots}", 150, 275, 10, 1, 1, color = 0xff_44ffff)
    @timer +=1
    if @speed ==0
    elsif @speed <0
      @speed = 0
    elsif @speed > 10
      @speed =10
    else
      if @timer % coolspeed == 0
        @dots.times {kolorek}
      end
    end
  end
end
