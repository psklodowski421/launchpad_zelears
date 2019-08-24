require 'unimidi'


notes=*(267..345)
output = UniMIDI::Output.gets
color=10
note_2= 267
loop do
notes.each do |note|
output.puts(0x90,note,color)
end
color +=2
sleep(0.1)
notes.each do |note|
output.puts(0x80,note,color)
end
sleep(0.1)
if color ==100
  notes.each do |note|
  output.puts(0x80,note,color)
end
  break
end
end
