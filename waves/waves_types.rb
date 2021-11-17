# frozen_string_literal: true

module Waves_types
  def logic_mapping
    if @counter >= 15
      case @type
      when 1
        rot_from_back = @memory_core.pop
        @memory_core.unshift(rot_from_back)
        @pulse_counter = 0
      when 2
        rot_from_back = @memory_core.shift
        @memory_core.push(rot_from_back)
        @pulse_counter = 0
      when 3
        if @pulse_counter <= 26
          rot_from_back = @memory_core.pop
          @memory_core.unshift(rot_from_back)
        elsif @pulse_counter >= 27
          rot_from_back = @memory_core.shift
          @memory_core.push(rot_from_back)
          @pulse_counter = 0 if @pulse_counter >= 52
        end
        @pulse_counter += 1
      end
    else
      rainbow
    end
    display
    @counter += 1
  end

  def display
    color = @memory_core.shift
    @zero.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @one.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @two.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @three.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @four.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @five.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @six.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @seven.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @eight.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @nine.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @ten.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @eleven.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @twelve.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @thirteen.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
    color = @memory_core.shift
    @fourteen.each do |note|
      output.puts(0x90, note, color)
    end
    @memory_core.push(color)
  end

  def rainbow
    real_color0 = 0
    @color_0 += 1
    @color_0 = 0 if @color_0 > 14
    if @color_0 >= 0
      @memory_core.unshift(real_color0)
      @memory_core.pop
    end
    @color_1 += 1
    real_color1 = 59
    @color_1 = 0 if @color_1 > 14
    if @color_1 >= 0
      @memory_core.unshift(real_color1)
      @memory_core.pop
    end
    @color_2 += 1
    real_color2 = 57
    @color_2 = 0 if @color_2 > 14
    if @color_2 >= 0
      @memory_core.unshift(real_color2)
      @memory_core.pop
    end
    @color_3 += 1
    real_color3 = 5
    @color_3 = 0 if @color_3 > 14
    if @color_3 >= 0
      @memory_core.unshift(real_color3)
      @memory_core.pop
    end
    @color_4 += 1
    real_color4 = 84
    @color_4 = 0 if @color_4 > 14
    if @color_4 >= 0
      @memory_core.unshift(real_color4)
      @memory_core.pop
    end
    @color_5 += 1
    real_color5 = 124
    @color_5 = 0 if @color_5 > 14
    if @color_5 >= 0
      @memory_core.unshift(real_color5)
      @memory_core.pop
    end
    @color_6 += 1
    real_color6 = 87
    @color_6 = 0 if @color_6 > 14
    if @color_6 >= 0
      @memory_core.unshift(real_color6)
      @memory_core.pop
    end
    @color_7 += 1
    real_color7 = 78
    @color_7 = 0 if @color_7 > 14
    if @color_7 >= 0
      @memory_core.unshift(real_color7)
      @memory_core.pop
    end
    @color_8 += 1
    real_color8 = 67
    @color_8 = 0 if @color_8 > 14
    if @color_8 >= 0
      @memory_core.unshift(real_color8)
      @memory_core.pop
    end
    @color_9 += 1
    real_color9 = 69
    @color_9 = 0 if @color_9 > 14
    if @color_9 >= 0
      @memory_core.unshift(real_color9)
      @memory_core.pop
    end
    @color_10 += 1
    real_color10 = 51
    @color_10 = 0 if @color_10 > 14
    if @color_10 >= 0
      @memory_core.unshift(real_color10)
      @memory_core.pop
    end
    @color_11 += 1
    real_color11 = 0
    @color_11 = 0 if @color_11 > 14
    if @color_11 >= 0
      @memory_core.unshift(real_color11)
      @memory_core.pop
    end
    @color_12 += 1
    real_color12 = 0
    @color_12 = 0 if @color_12 > 14
    if @color_12 >= 0
      @memory_core.unshift(real_color12)
      @memory_core.pop
    end
    @color_13 += 1
    real_color13 = 0
    @color_13 = 0 if @color_13 > 14
    if @color_13 >= 0
      @memory_core.unshift(real_color13)
      @memory_core.pop
    end
    @color_14 += 1
    real_color14 = 0
    @color_14 = 0 if @color_14 > 14
    if @color_14 >= 0
      @memory_core.unshift(real_color14)
      @memory_core.pop
    end
  end
end
