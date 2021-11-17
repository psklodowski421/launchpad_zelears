# frozen_string_literal: true

module Connection
  attr_accessor :notes, :output, :table

  def connect
    @output = UniMIDI::Output.use(:first)
  end

  def notes
    @notes =
      [267, 268, 269, 270, 271, 272, 273, 274,
       277, 278, 279, 280, 281, 282, 283, 284,
       287, 288, 289, 290, 291, 292, 293, 294,
       297, 298, 299, 300, 301, 302, 303, 304,
       307, 308, 309, 310, 311, 312, 313, 314,
       317, 318, 319, 320, 321, 322, 323, 324,
       327, 328, 329, 330, 331, 332, 333, 334,
       337, 338, 339, 340, 341, 342, 343, 344]
  end
end
