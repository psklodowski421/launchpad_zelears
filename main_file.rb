#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'csv'
Bundler.require

$LOAD_PATH.unshift(File.join('..', 'lib'))
Dir['./*.rb'].sort.each { |file| require file }
Dir['./snake/*.rb'].sort.each { |file| require file }
Dir['./random/*.rb'].sort.each { |file| require file }
Dir['./full_board/*.rb'].sort.each { |file| require file }
Dir['./notes_detect/*.rb'].sort.each { |file| require file }
Dir['./waves/*.rb'].sort.each { |file| require file }
Dir['./paint/*.rb'].sort.each { |file| require file }
Dir['./osu/*.rb'].sort.each { |file| require file }

WIDTH = 1000
HEIGHT = 800

class MainLauncher < Gosu::Window
  include Launchpad
  include Objects
  include Connection
  include Config
  def initialize
    super 640, 480
    # connect
    self.caption = 'Party Maker!'

    text =
      "Launchpad Menu
       Snake - 1
       Sleeper - 2
       Full board 1 color - 3
       Waves - 4
       Paint - 5"

    # Remove all leading spaces so the text is left-aligned
    text.gsub!(/^ +/, '')

    @text = Gosu::Image.from_text text, 20
    clear
    @background = Gosu::Image.new 'media/space.png'
  end

  def draw
    menu
  end

  def button_down(id)
    case id
    when Gosu::KB_1
      Snake.new.show
    when Gosu::KB_2
      Sleeper.new.show
    when Gosu::KB_3
      Full_board.new.show
    when Gosu::KB_4
      Waves.new.show
    when Gosu::KB_5
      Paint.new.show
    when Gosu::KB_6
      Osu.new.show
    when Gosu::KB_ESCAPE
      exit
    end
  end
end

MainLauncher.new.show if __FILE__ == $PROGRAM_NAME
