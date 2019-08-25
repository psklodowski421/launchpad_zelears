module Testme
  attr_accessor :random_memory

  def controller
    counter
    display_pos
    checker
  end

  def

  def display_pos
    if @dots_position.count < 10
      if @counter % 60
        generate_dot
      end
    end
  end

  def generate_dot
    @output.puts(0x90, sample=@notes_osu.sample, rand(1..120))
    @dots_position << sample
  end

  def checker
    unless input.buffer.empty?
      input.buffer.each do |data|
        @check_position = data[:data][1]
        @check_color = data[:data][2]
      end
      input.buffer.clear
    end
  end

  def counter
    if @counter < 1000
      @counter += 1
    else
      @counter = 0
    end
  end
end
