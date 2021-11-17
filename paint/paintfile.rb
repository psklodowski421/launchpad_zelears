# frozen_string_literal: true

$LOAD_PATH.unshift(File.join('..', 'lib'))
Dir['./*.rb'].sort.each { |file| require file }

WIDTH = 1000
HEIGHT = 800

class Paint < Gosu::Window
  include Launchpad
  include Objects
  include Connection
  include Input
  def initialize
    super 640, 480
    connect
    input
    @font = Gosu::Font.new(50)
    self.caption = 'Paint'
    @notes =
      [267, 268, 269, 270, 271, 272, 273, 274, 275,
       277, 278, 279, 280, 281, 282, 283, 284, 285,
       287, 288, 289, 290, 291, 292, 293, 294, 295,
       297, 298, 299, 300, 301, 302, 303, 304, 305,
       307, 308, 309, 310, 311, 312, 313, 314, 315,
       317, 318, 319, 320, 321, 322, 323, 324, 325,
       327, 328, 329, 330, 331, 332, 333, 334, 335,
       337, 338, 339, 340, 341, 342, 343, 344, 345]
    @topbuttons = [104, 105, 106, 107, 108, 109, 110, 111]
    @color = 1
    @check_color = []
    @check_status = []
    @color_mem = 0
    @toggle = 1
    @color1 = 1
    @color2 = 2
    @color3 = 3
    @color4 = 4
    @color5 = 5
    @toggle_color_type = 0
    @color_type = [144, 145, 146]
    @array_of_hashes = []

    @background = Gosu::Image.new 'media/space.png'
  end

  def draw
    @font.draw_text("Color: #{@color}", 170, 100, 10, 1, 1, color = 0xff_ffffff)
    @font.draw_text("Color 1: #{@color1}", 170, 150, 10, 1, 1, color = 0xff_ffffff)
    @font.draw_text("Color 2: #{@color2}", 170, 200, 10, 1, 1, color = 0xff_ffffff)
    @font.draw_text("Color 3: #{@color3}", 170, 250, 10, 1, 1, color = 0xff_ffffff)
    @font.draw_text("Color 4: #{@color4}", 170, 300, 10, 1, 1, color = 0xff_ffffff)
    @font.draw_text("Color 5: #{@color5}", 170, 350, 10, 1, 1, color = 0xff_ffffff)
    paint
    checker
    tools
  end

  def button_down(id)
    case id
    when Gosu::KB_1
      notes.each do |note|
        @output.puts(0x80, note, 15)
      end
    when Gosu::KB_2
      @color -= 1
    when Gosu::KB_3
      @color += 1
    when Gosu::KB_4

    when Gosu::KB_5

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
