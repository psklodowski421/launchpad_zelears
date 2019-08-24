module Input
  def input
    @input = UniMIDI::Input.use(:first)
  end

  def tools

    output.puts(0x90,89,@color)
    @output.puts(146,79,67)
    @output.puts(0x90,69,@color1)
    @output.puts(0x90,59,@color2)
    @output.puts(0x90,49,@color3)
    @output.puts(0x90,39,@color4)
    @output.puts(0x90,29,@color5)
    @output.puts(146,19,67)
    @output.puts(176,104,20)
    if @toggle == 0
      @output.puts(178,105,3)
    else
      @output.puts(176,105,1)
    end

  end

  def checker
    @check_color.each do |chk|
      case
        when chk == 104
          notes.each do |note|
            @output.puts(0x80,note,15)
          end
        when chk == 105
          if @check_status == 127
            if @toggle == 0
              @color = @color_mem
              @toggle = 1
            else
            @color_mem = @color
            @color = 0
            @toggle = 0
            end
          end
        when chk == 79
          if @check_status == 127
            @color1 += 5
            @color2 += 5
            @color3 += 5
            @color4 += 5
            @color5 += 5
          end
        when chk == 69
          if @check_status == 127
            @color = @color1
          end
        when chk == 59
          if @check_status == 127
            @color = @color2
          end
        when chk == 49
          if @check_status == 127
            @color = @color3
          end
        when chk == 39
          if @check_status == 127
            @color = @color4
          end
        when chk == 29
          if @check_status == 127
            @color = @color5
          end
        when chk == 19
          if @check_status == 127
            @color1 -= 5
            @color2 -= 5
            @color3 -= 5
            @color4 -= 5
            @color5 -= 5
        end
      end
    end
    if @color1 > 127
      @color1 = 1
    end
    if @color2 > 130
      @color2 = 2
    end
    if @color3 > 130
      @color3 = 3
    end
    if @color4 > 130
      @color4 = 4
    end
    if @color5 > 131
      @color5 = 5
    end
    if @color1 < 0
      @color1 = 126
    end
    if @color2 < 0
      @color2 = 127
    end
    if @color3 < 0
      @color3 = 128
    end
    if @color4 < 0
      @color4 = 129
    end
    if @color5 <= 0
      @color5 = 130
    end

    @check_color =[]
    @check_status = 0

  end

  def paint
    if input.buffer.empty? == true

    end
    if input.buffer.empty? == false
      puts input.buffer
      input.buffer.each do |data|
        output.puts(0x90,data[:data][1],@color)
        @check_color << data[:data][1]
        @check_status = data[:data][2]
      end
      input.buffer.clear
    end
  end
end
