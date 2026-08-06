#!/usr/bin/env rexx
-- syslog.rex
-- Example sending log messages to a Syslog server.
-- It uses `logger`.

log = .Logger~new()

log~formatter = .SysLogFormatter~new()
log~output    = .SyslogOutput~new()

log~info("oorexx-tinylog example!")

exit

::requires 'TinyLog'

::class SysLogFormatter

::method call
  use arg record

  return "[" || record~source ||":" || record~line "]" record~message

::class SyslogOutput

::method say
  use arg line
  clear_line = line~changestr('"', '\"')
  address system 'logger -t oorexx-tinylog "' || line || '"'
  return rc
