#!/usr/bin/env rexx
-- outputs.rex
-- Examples of different log output destinations.
-- Three simple output implementations:
--   * NullOutput    : discards messages.
--   * MemoryOutput  : stores messages in memory.
--   * TeeOutput     : forwards messages to multiple outputs.

log = .Logger~new()

say "-- TinyLog: output destinations"
say

say '-- The .error monitor (usually .stderr)'
log~output = .error
log~info("Output to .error")
say

say '-- A Stream object'
log~output = .Stream~new("outputs.log")
log~info("File output")
say

say '-- Memory' 
memory = .MemoryOutput~new
log~output = memory
log~error("Memory output")
log~error("Second line")
say 'From memory:' memory~lines[2]
say

say '-- Multiple outputs'
log~output = .TeeOutput~new((.output, .error))
log~fatal("Multiple outputs")
say

say '-- Null'
log~output = .NullOutput~new
log~info("This secondary output is discarded.")

exit

::requires 'TinyLog'

::class NullOutput

::method say
  return

-- Storing log messages in memory.
::class MemoryOutput

::attribute lines

::method init
  self~lines = .Array~new

::method say
  use arg line
  self~lines~append(line)

-- Redirecting log messages to several outputs.
::class TeeOutput

::method init
  expose outputs
  use arg outputs = (,)
  
::method say
  expose outputs
  use arg str
  
  do i = 1 to outputs~items
    outputs[i]~say(str)
  end
