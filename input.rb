dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + "/../lib"

require "unimidi"

# Prompts the user to select a midi input
# Sends an inspection of the first 10 messages messages that input receives to standard out

num_messages = 10

# Prompt the user
require "unimidi"
input = UniMIDI::Input.use(:first)
output = UniMIDI::Output.use(:first)
# using their selection...

loop do
  sleep(0.01)
  if input.buffer.empty? == true
  puts "clear"
  next
end
if input.buffer.empty? == false
  puts input.buffer
  output.puts(0x90,input.buffer[0][:data][1],120)
  input.buffer.clear
end
end
