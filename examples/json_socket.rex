#!/usr/bin/env rexx
-- json_socket.rex
-- Send structured JSON logs over a TCP socket.
-- Before running this example:
--   nc -l 8888

log = .Logger~new()

-- The formatter returns JSON
log~formatter = .routines['JSONFORMATTER']

-- The output goes to a socket
so = .StreamSocket~new('localhost', '8888')
log~output = so

log~info("This is simple information.")
log~error("This is an error.")
  
exit

::requires 'TinyLog'
::requires 'JSON.cls'
::requires 'streamsocket.cls'

::routine JSONFormatter
  use arg record

  -- Remove non-serializable objects.
  record~remove('CONTEXT')
  
  return .JSON~toJSON(record)
