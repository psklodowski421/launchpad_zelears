require 'unimidi'

notes=*(267..345)
output = UniMIDI::Output.gets
color=10
notes.each do |note|
output.puts(0x80,note,color)
end

note_2= 267
loop do
output.puts(0x90,note_2,30)
puts note_2
sleep(0.1)
note_2+=1
 if note_2 ==346
   notes.each do |note|
   output.puts(0x80,note,color)
 end
  break
end
end
