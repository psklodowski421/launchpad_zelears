# frozen_string_literal: true

require 'rubygems'
require 'gosu'
require 'unimidi'
require 'matrix'
require 'midi-eye'
require 'pry'
require_relative './osu_logics'
$LOAD_PATH.unshift(File.join('..', 'lib'))
Dir['./*.rb'].sort.each { |file| require file }

WIDTH = 1000
HEIGHT = 800

class Osu < Gosu::Window
  include Launchpad
  include Objects
  include Connection
  include Config
  include Testme
  def initialize
    super 640, 480
    connect
    input
    @notes = [
      267, 268, 269, 270, 271, 272, 273, 274, 275,
      277, 278, 279, 280, 281, 282, 283, 284, 285,
      287, 288, 289, 290, 291, 292, 293, 294, 295,
      297, 298, 299, 300, 301, 302, 303, 304, 305,
      307, 308, 309, 310, 311, 312, 313, 314, 315,
      317, 318, 319, 320, 321, 322, 323, 324, 325,
      327, 328, 329, 330, 331, 332, 333, 334, 335,
      337, 338, 339, 340, 341, 342, 343, 344, 345
    ]
    @notes_osu = [
      81, 82, 83, 84, 85, 86, 87, 88,
      71, 72, 73, 74, 75, 76, 77, 78,
      61, 62, 63, 64, 65, 66, 67, 68,
      51, 52, 53, 54, 55, 56, 57, 58,
      41, 42, 43, 44, 45, 46, 47, 48,
      31, 32, 33, 34, 35, 36, 37, 38,
      21, 22, 23, 24, 25, 26, 27, 28,
      11, 12, 13, 14, 15, 16, 17, 18
    ]
    @topbuttons = [104, 105, 106, 107, 108, 109, 110, 111]
    self.caption = 'Osu!'
    @font = Gosu::Font.new(50)

    @counter = 0
    @dots_position = []
  end

  def draw
    @font.draw_text('Its Osu', 250, 250, 10, 1, 1, color = 0xff_44ffff)
    controller
  end

  def button_down(id)
    case id
    when Gosu::KB_1
    when Gosu::KB_ESCAPE
      notes.each do |note|
        @output.puts(0x80, note, 15)
      end
      @topbuttons.each do |note|
        @output.puts(176, note, 0)
      end
      MainLauncher.new.show
      close
    end
  end
end

MainLauncher.new.show if __FILE__ == $PROGRAM_NAME
