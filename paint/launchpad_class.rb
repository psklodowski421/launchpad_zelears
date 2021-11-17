# frozen_string_literal: true

module Launchpad
  include Connection
  attr_accessor :notes, :output, :table

  #  def oldconnect
  #    @output = UniMIDI::Output.gets
  #    @table=Matrix[
  #      [337,338,339,340,341,342,343,344],
  #      [327,328,329,330,331,332,333,334],
  #      [317,318,319,320,321,322,323,324],
  #      [307,308,309,310,311,312,313,314],
  #      [297,298,299,300,301,302,303,304],
  #      [287,288,289,290,291,292,293,294],
  #      [277,278,279,280,281,282,283,284],
  #      [267,268,269,270,271,272,273,274]]
  #    @notes=
  #    [267,268,269,270,271,272,273,274,
  #     277,278,279,280,281,282,283,284,
  #     287,288,289,290,291,292,293,294,
  #     297,298,299,300,301,302,303,304,
  #     307,308,309,310,311,312,313,314,
  #     317,318,319,320,321,322,323,324,
  #     327,328,329,330,331,332,333,334,
  #     337,338,339,340,341,342,343,344]
  #  end
  def commands
    puts "\n    on(color)
    light_on(table.row() || table.column(),color)
    off
    loading
    random
    pulse"
  end

  def on(color)
    notes.each do |note|
      output.puts(0x90, note, color)
    end
  end

  def onxy(target)
    output.puts(0x90, target, 20)
  end

  def light_on(table, color)
    table.each do |note|
      output.puts(0x90, note, color)
    end
  end

  def off
    notes.each do |note|
      output.puts(0x80, note, 20)
    end
  end

  def loading
    note_1 = [267, 268, 269, 270, 271, 272, 273, 274]

    note_2 = [284, 283, 282, 281, 280, 279, 278, 277]
    timer = 0.05
    4.times do
      note_1.each do |note|
        output.puts(0x90, note, 30)
        sleep(timer)
      end
      note_1.map! { |add| add + 20 } unless note_1 == [327, 328, 329, 330, 331, 332, 333, 334]
      note_2.each do |note|
        output.puts(0x90, note, 30)
        sleep(timer)
      end
      note_2.map! { |add| add + 20 } unless note_2 == [344, 343, 342, 341, 340, 339, 338, 337]
    end
    4.times do
      note_2.each do |note|
        output.puts(0x80, note, 30)
        sleep(timer)
      end
      note_2.map! { |add| add - 20 }
      note_1.each do |note|
        output.puts(0x80, note, 30)
        sleep(timer)
      end
      note_1.map! { |add| add - 20 }
    end
    notes.each do |reset|
      output.puts(0x80, reset, 1)
    end
  end

  def random
    timer = 0.01
    memory = []
    number = 0
    loop do
      output.puts(0x90, notes.sample, rand(1..120))
      sleep(timer)
    end
  end

  def testing
    a = @table.row(1)
    a.each do |note|
      output.puts(0x90, note, 12)
    end
  end

  def pulse(timer)
    200.times do
      row_top = 0
      row_down = 7
      column_top = 0
      column_down = 7
      e = 3
      random = rand(1..120)
      random_2 = rand(1..120)
      counter = 0
      4.times do
        counter += 1
        a = @table.row(row_top).to_a
        b = @table.row(row_down).to_a
        c = @table.column(column_top).to_a
        d = @table.column(column_down).to_a
        a.each do |note|
          output.puts(0x90, note, random)
        end
        b.each do |note|
          output.puts(0x90, note, random)
        end
        c.each do |note|
          output.puts(0x90, note, random)
        end
        d.each do |note|
          output.puts(0x90, note, random)
        end
        row_top += 1
        row_down -= 1
        column_top += 1
        column_down -= 1
        sleep(timer)
        next unless counter == 4

        4.times do
          row_top -= 1
          row_down += 1
          column_top -= 1
          column_down += 1
          a = @table.row(row_top).to_a
          b = @table.row(row_down).to_a
          c = @table.column(column_top).to_a
          d = @table.column(column_down).to_a
          a.shift(e)
          a.pop(e)
          b.shift(e)
          b.pop(e)
          c.shift(e)
          c.pop(e)
          d.shift(e)
          d.pop(e)
          e -= 1
          a.each do |note|
            output.puts(0x90, note, random_2)
          end
          b.each do |note|
            output.puts(0x90, note, random_2)
          end
          c.each do |note|
            output.puts(0x90, note, random_2)
          end
          d.each do |note|
            output.puts(0x90, note, random_2)
          end
          sleep(timer)
        end
      end
    end
  end
end
