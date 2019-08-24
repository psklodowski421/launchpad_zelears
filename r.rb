dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'

require "unimidi"

# Prompts the user to select a MIDI output
# Sends a MIDI system exclusive message to that output

sysex_msg = [240, 0,  32, 41,  2,24,35, 292,50,247]
sysex_msg1 = []

output = UniMIDI::Output.gets

output.puts(sysex_msg)
output.puts(sysex_msg1)
