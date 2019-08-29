module Input
  ##
  def input
    @input = UniMIDI::Input.use(:first)
  end
  ##
  def tools

    output.puts(@color_type[@toggle_color_type],89,@color)
    @output.puts(144,79,126)
    @output.puts(0x90,69,@color1)
    @output.puts(0x90,59,@color2)
    @output.puts(0x90,49,@color3)
    @output.puts(0x90,39,@color4)
    @output.puts(0x90,29,@color5)
    @output.puts(144,19,126)
    @output.puts(176,104,20)
    if @toggle == 0
      @output.puts(178,105,3)
    else
      @output.puts(176,105,1)
    end
    @output.puts(176,106,57)
    @output.puts(176,107,64)

  end

  def checker
    @check_color.each do |chk|
        case
        when chk == 104
          if @check_status == 127
            notes.each do |note|
              @output.puts(0x80,note,15)
            end
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
        when chk == 106
          if @check_status == 127
            to_csv(@array_of_hashes)
          end
        when chk == 107
          if @check_status == 127
            loader = CSV.read("hash.csv")
            loader.each do |ob|
              mapper=[]
              mapper=ob.map{ |i| i.to_i }
                if mapper[1] == 104
                  notes.each do |note|
                    @output.puts(0x80,note,15)
                  end
                end
              @output.puts(mapper[0],mapper[1],mapper[2])
              loaded_hashes = {"voltage"=>mapper[0],"position"=>mapper[1], "color"=>mapper[2] }
              @array_of_hashes << loaded_hashes
              sleep(0.001)
            end
          end

        when chk == 89
          if @check_status == 127
            @toggle_color_type +=1
            if @toggle_color_type == 1
              @output.puts(144,89,0)
            end
            if @toggle_color_type == 3
              @toggle_color_type = 0
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
    if input.buffer.empty? == false
      input.buffer.each do |data|
        output.puts(@color_type[@toggle_color_type],data[:data][1],@color)
        @check_color << data[:data][1]
        @check_status = data[:data][2]
        saving
      end
      input.buffer.clear
    end
  end

  def saving
    if input.buffer[0][:data][2] == 0
    else
      hash = {"voltage"=>nil,"position"=>nil, "color"=>nil }
      hash["voltage"] = @color_type[@toggle_color_type]
      hash["position"] =  input.buffer[0][:data][1]
      hash["color"] =  @color
      puts hash
      @array_of_hashes << hash
    end
  end

  def to_csv(file)
      require 'csv'
      CSV.open("hash.csv", "wb") do |csv|
        file.each do |hash|
          csv << hash.values
          end
        end
  end
end
