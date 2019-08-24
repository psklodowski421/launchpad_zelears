require 'gosu'
require 'unimidi'
require 'matrix'
require "midi-eye"
require 'pry'
$:.unshift(File.join("..", "lib"))

class Waves < Gosu::Window
  include Gamerules
  include Connection
  include Waves_types

  def initialize
    super 600, 600
    self.caption = "Waves"
    connect
    @font = Gosu::Font.new(20)
    @zero = [337]
    @one = [327,338]
    @two = [317,328,339]
    @three = [307,318,329,340]
    @four = [297,308,319,330,341]
    @five = [287,298,309,320,331,342]
    @six = [277,288,299,310,321,332,343]
    @seven = [267,278,289,300,311,322,333,344]
    @eight = [268,279,290,301,312,323,334]
    @nine = [269,280,291,302,313,324]
    @ten = [270,281,292,303,314]
    @eleven = [271,282,293,304]
    @twelve = [272,283,294]
    @thirteen = [273,284]
    @fourteen = [274]
    @memory_core = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @counter = 0
    @color_0 = 0
    @color_1 = -1
    @color_2 = -2
    @color_3 = -3
    @color_4 = -4
    @color_5 = -5
    @color_6 = -6
    @color_7 = -7
    @color_8 = -8
    @color_9 = -9
    @color_10 = -10
    @color_11 = -11
    @color_12 = -12
    @color_13 = -13
    @color_14 = -14
    @font = Gosu::Font.new(50)
    @speed = 0.07
    @type = 1
    @pulse_counter= 0
  end

  def button_down(id)
    case id
    when Gosu::KB_UP
      @speed +=0.01
    when Gosu::KB_DOWN
      @speed -=0.002
    when Gosu::KB_RIGHT
      @type += 1
    when Gosu::KB_LEFT
      @type -= 1
    when Gosu::KB_ESCAPE
      notes.each do |note|
        @output.puts(0x80,note,15)
      end
      Welcome.new.show
      close
    end
  end

  def update
  end

  def draw
      logic_mapping
      sleep(@speed)
      @font.draw_text("Pulse_counter: #{@pulse_counter}", 170, 150, 10, 1, 1, color = 0xff_ffffff)
      @font.draw_text("Type: #{@type}", 170, 250, 10, 1, 1, color = 0xff_ffffff)
      @font.draw_text("Speed: #{sprintf('%.3f', @speed)}", 170, 350, 10, 1, 1, color = 0xff_ffffff)
      @font.draw_text("Counter: #{@counter}", 170, 450, 10, 1, 1, color = 0xff_ffffff)
  end

end
