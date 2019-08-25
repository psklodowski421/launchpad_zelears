require 'gosu'
require 'unimidi'
require 'matrix'
require "midi-eye"
require 'pry'
$:.unshift(File.join("..", "lib"))
Dir["./*.rb"].each {|file| require file }

class Full_board < Gosu::Window
  attr_accessor :esc, :color, :text, :background1
  include Config
  include Control
  include Gamerules
  include Connection

  def initialize
    super 1000, 800
    self.caption = "When you missing light ;)"
    @esc = 0
    @color = 0
    connect
    @font = Gosu::Font.new(50)
    @background1 = Gosu::Image.new "media/colors.png"
  end

  def button_down(id)
    case id
    when Gosu::KB_RIGHT
      @color += 1
    when Gosu::KB_LEFT
      @color -= 1
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

  def on
    notes.each do |note|
      output.puts(0x90,note,
      if @color < 0
        @color = 127
      elsif @color > 127
        @color =0
      else
        @color
      end
      )
    end
  end

  def update
  end

  def draw
    @font.draw_text("Color: #{color}", 430, 550, 10, 1, 1, color = 0xff_ffffff)
    on
    @background1.draw(1,1,1, scale_x = 0.5, scale_y = 0.5, color = 0xff_ffffff, mode = :default)
  end
end
