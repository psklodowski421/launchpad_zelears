module Testme
  attr_accessor :random_memory
  def shower
    if @counter % 60 == 0
      if @dots_number < 11 == true
        @dots_number += 1
        @output.puts(0x90,@random_memory = @notes_osu.sample,rand(1..120))
        @array_of_dots.push(@random_memory)
        @notes_osu.delete()
      end
    end
  end

  def remove
    @array_of_dots.each do |element|
      if element == @check_position
        @output.puts(0x80,@check_position,0)
        @array_of_dots.delete(@check_position)
        @dots_number -=1
      end
    end
  end

  def checker
    if input.buffer.empty? == false
      input.buffer.each do |data|
        @check_position = data[:data][1]
        @check_color = data[:data][2]
      end
      remove
      input.buffer.clear
    end
  end

  def counter
    if @counter < 1000 == true
      @counter +=1
    else
      @counter = 0
    end
  end
end
