#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'gosu'
require 'unimidi'
require 'matrix'
require "midi-eye"
require 'pry'
$:.unshift(File.join("..", "lib"))
Dir["./*.rb"].each {|file| require file }
Dir["./snake/*.rb"].each {|file| require file }
Dir["./random/*.rb"].each {|file| require file }
Dir["./full_board/*.rb"].each {|file| require file }
Dir["./notes_detect/*.rb"].each {|file| require file }
Dir["./waves/*.rb"].each {|file| require file }
Dir["./paint/*.rb"].each {|file| require file }
Dir["./osu/*.rb"].each {|file| require file }

WIDTH, HEIGHT = 1000, 800


class Welcome <  Gosu::Window
  include Launchpad
  include Objects
  include Connection
  include Config
  def initialize
    super 640, 480
    # connect
    self.caption = "Party Maker!"

    text =
      "Launchpad Menu
       Snake - 1
       Sleeper - 2
       Full board 1 color - 3
       Waves - 4
       Paint - 5"


    # Remove all leading spaces so the text is left-aligned
    text.gsub! /^ +/, ""

    @text = Gosu::Image.from_text text, 20
    clear
    @background = Gosu::Image.new "media/space.png"
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
      close
    end
  end
end

Welcome.new.show if __FILE__ == $0
