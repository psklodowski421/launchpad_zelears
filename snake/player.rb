module Control

end

module Gamerules
  def gamestate
    if @gameover == 0
    move
    end
    if @gameover == 1
      notes.each do |note|
        @output.puts(0x80,note,15)
      end
      scoreboard = "#{@body.length} Points "
      ancii =[]
      scoreboard.each_byte do |byte|
         ancii << [byte]
      end
      converted= ancii.flatten
      @output.puts(240,0, 32, 41, 2,  24, 20, 3,0,  *converted,     247)
      @gameover = 2
      rip
    end
    if @gameover == 2
      @light +=1
      if @light % 30 ==0
        @lights.each do |death|
          output.puts(0x90,table[*death],60)
        end
      elsif @light % 50 ==0
        @lights.each do |death|
          output.puts(0x80,table[*death],60)
        end
      end
      print "\nNoob"
    end
  end
end
