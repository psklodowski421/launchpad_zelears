# frozen_string_literal: true

module Config
  def clear
    if Gem.win_platform?
      system 'cls'
    else
      system 'clear'
    end
  end

  def initializers
    clear
    print 'Get Ready'
    sleep(1)
    clear
    print '3'
    sleep(1)
    clear
    print '2'
    sleep(1)
    clear
    print '1'
    sleep(1)
    @light = 0
    @done = 0
    @status = 0
    @gameover = 0
    @fps = 0
    @table = Matrix[
      [337, 338, 339, 340, 341, 342, 343, 344],
      [327, 328, 329, 330, 331, 332, 333, 334],
      [317, 318, 319, 320, 321, 322, 323, 324],
      [307, 308, 309, 310, 311, 312, 313, 314],
      [297, 298, 299, 300, 301, 302, 303, 304],
      [287, 288, 289, 290, 291, 292, 293, 294],
      [277, 278, 279, 280, 281, 282, 283, 284],
      [267, 268, 269, 270, 271, 272, 273, 274]]
    @bottom = [[7, 3], [7, 4], [6, 3], [6, 4], [5, 3], [5, 4]]
    @bottom_sides = [[7, 2], [7, 5], [6, 2], [6, 5], [5, 2], [5, 5], [4, 2], [4, 3], [4, 4], [4, 5]]
    @lights = [[2, 3], [2, 4], [1, 3], [1, 4]]
    @notes =
      [267, 268, 269, 270, 271, 272, 273, 274,
       277, 278, 279, 280, 281, 282, 283, 284,
       287, 288, 289, 290, 291, 292, 293, 294,
       297, 298, 299, 300, 301, 302, 303, 304,
       307, 308, 309, 310, 311, 312, 313, 314,
       317, 318, 319, 320, 321, 322, 323, 324,
       327, 328, 329, 330, 331, 332, 333, 334,
       337, 338, 339, 340, 341, 342, 343, 344]
    @x = 5
    @y = 3
    @body = [[3, 3], [3, 4], [3, 5]]
    @dir = 3
    @color = 66
    @memory = table[@y, @x]
    @head = [@y, @x]
    @notes.each do |note|
      @output.puts(0x80, note, 15)
    end
    @body.each do |array|
      output.puts(0x90, table[*array], @color)
    end
    @apple = [@appley = rand(0..7), @applex = rand(0..7)]
    @output.puts(0x90, table[@appley, @applex], 120)
  end
end
