# frozen_string_literal: true

$LOAD_PATH.unshift(File.join('..', 'lib'))
Dir['./*.rb'].sort.each { |file| require file }

class Sleeper < Gosu::Window
  attr_accessor :esc, :speed, :text, :timer

  include Connection

  def initialize
    super 600, 600
    self.caption = 'Fun Light'
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
        @output.puts(0x80, note, 15)
      end
      MainLauncher.new.show
      close
    end
  end

  def teksty
    text.draw
  end

  def kolorek
    output.puts(0x90, notes.sample, rand(1..120))
  end

  def coolspeed
    (-1 * @speed) + 11
  end

  def update; end

  def draw
    @font.draw_text("Speed: #{speed}", 250, 250, 10, 1, 1, color = 0xff_44ffff)
    @font.draw_text("Number of dots changes in cycle: #{@dots}", 150, 275, 10, 1, 1, color = 0xff_44ffff)
    @timer += 1
    if @speed.zero?
    elsif @speed.negative?
      @speed = 0
    elsif @speed > 10
      @speed = 10
    elsif (@timer % coolspeed).zero?
      @dots.times { kolorek }
    end
  end
end
