require 'unimidi'

notes=*(267..345)
output = UniMIDI::Output.gets
color=10
notes.each do |reset|
output.puts(0x80,reset,color)
end
counter=0
note_1=[267, 268, 269, 270, 271, 272, 273, 274]

note_2=[284, 283, 282, 281, 280, 279, 278, 277]
timer=0.05
loop do
  note_1.each { |note| output.puts(0x90,note,30);sleep(timer)}
  note_1.map!{|add| add+20}
  note_2.each { |note| output.puts(0x90,note,30);sleep(timer)}
  note_2.map!{|add| add+20}
counter +=1
puts counter
if counter ==4
  notes.each do |reset|
  output.puts(0x80,reset,color)
  end
  break

end
end
