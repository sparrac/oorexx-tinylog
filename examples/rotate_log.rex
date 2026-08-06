#!/usr/bin/env rexx
-- rotate_log.rex
-- Simple rotate log implementation

log = .Logger~new()

-- The output goes to a RotateOutput object
ro = .RotateOutput~new('rotate_log.log')
log~output = ro

log~info("This is simple information.")
log~error("This is an error.")
  
exit

::requires 'TinyLog'

::class RotateOutput

::attribute filename
::attribute stream
::attribute maxSize

::method init
  expose filename stream maxSize
  use arg filename, maxSize = 1200

  self~filename = filename
  self~maxSize  = maxSize
  self~stream   = .Stream~new(filename)
  self~stream~open("APPEND")
  
::method rotate
  if self~stream~query('SIZE') < self~maxSize then
    return
    
  self~stream~close
  
  call SysFileDelete self~filename".1"
  call SysFileMove self~filename, self~filename".1"

  self~stream = .Stream~new(self~filename)
  self~stream~open("REPLACE")

::method say
  use arg line
  
  self~rotate()
  self~stream~say(line)
