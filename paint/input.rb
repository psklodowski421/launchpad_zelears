# frozen_string_literal: true

module Input
  ##
  def input
    @input = UniMIDI::Input.first
  end

  ##
  def tools
    output.puts(@color_type[@toggle_color_type], 89, @color)
    @output.puts(144, 79, 126)
    @output.puts(0x90, 69, @color1)
    @output.puts(0x90, 59, @color2)
    @output.puts(0x90, 49, @color3)
    @output.puts(0x90, 39, @color4)
    @output.puts(0x90, 29, @color5)
    @output.puts(144, 19, 126)
    @output.puts(176, 104, 20)
    if @toggle.zero?
      @output.puts(178, 105, 3)
    else
      @output.puts(176, 105, 1)
    end
    @output.puts(176, 106, 57)
    @output.puts(176, 107, 64)
  end

  def checker
    @check_color.each do |chk|
      case chk
      when 104
        if @check_status == 127
          notes.each do |note|
            @output.puts(0x80, note, 15)
          end
        end
      when 105
        if @check_status == 127
          if @toggle.zero?
            @color = @color_mem
            @toggle = 1
          else
            @color_mem = @color
            @color = 0
            @toggle = 0
          end
        end
      when 106
        to_csv(@array_of_hashes) if @check_status == 127
      when 107
        if @check_status == 127
          loader = CSV.read('hash.csv')
          loader.each do |ob|
            mapper = []
            mapper = ob.map(&:to_i)
            if mapper[1] == 104
              notes.each do |note|
                @output.puts(0x80, note, 15)
              end
            end
            @output.puts(mapper[0], mapper[1], mapper[2])
            loaded_hashes = { 'voltage' => mapper[0], 'position' => mapper[1], 'color' => mapper[2] }
            @array_of_hashes << loaded_hashes
            sleep(0.001)
          end
        end

      when 89
        if @check_status == 127
          @toggle_color_type += 1
          @output.puts(144, 89, 0) if @toggle_color_type == 1
          @toggle_color_type = 0 if @toggle_color_type == 3
        end
      when 79
        if @check_status == 127
          @color1 += 5
          @color2 += 5
          @color3 += 5
          @color4 += 5
          @color5 += 5
        end
      when 69
        @color = @color1 if @check_status == 127
      when 59
        @color = @color2 if @check_status == 127
      when 49
        @color = @color3 if @check_status == 127
      when 39
        @color = @color4 if @check_status == 127
      when 29
        @color = @color5 if @check_status == 127
      when 19
        if @check_status == 127
          @color1 -= 5
          @color2 -= 5
          @color3 -= 5
          @color4 -= 5
          @color5 -= 5
        end
      end
    end
    @color1 = 1 if @color1 > 127
    @color2 = 2 if @color2 > 130
    @color3 = 3 if @color3 > 130
    @color4 = 4 if @color4 > 130
    @color5 = 5 if @color5 > 131
    @color1 = 126 if @color1.negative?
    @color2 = 127 if @color2.negative?
    @color3 = 128 if @color3.negative?
    @color4 = 129 if @color4.negative?
    @color5 = 130 if @color5 <= 0

    @check_color = []
    @check_status = 0
  end

  def paint
    if input.buffer.empty? == false
      input.buffer.each do |data|
        output.puts(@color_type[@toggle_color_type], data[:data][1], @color)
        @check_color << data[:data][1]
        @check_status = data[:data][2]
        saving
      end
      input.buffer.clear
    end
  end

  def saving
    if (input.buffer[0][:data][2]).zero?
    else
      hash = { 'voltage' => nil, 'position' => nil, 'color' => nil }
      hash['voltage'] = @color_type[@toggle_color_type]
      hash['position'] = input.buffer[0][:data][1]
      hash['color'] =  @color
      puts hash
      @array_of_hashes << hash
    end
  end

  def to_csv(file)
    require 'csv'
    CSV.open('hash.csv', 'wb') do |csv|
      file.each do |hash|
        csv << hash.values
      end
    end
  end
end
