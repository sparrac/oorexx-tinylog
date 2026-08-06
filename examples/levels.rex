#!/usr/bin/env rexx
-- levels.rex
-- Filtering messages by log level.

parse arg usecolors

log = .Logger~new() -- just the console

log~level = "WARN"

log~trace("This message is ignored.")
log~debug("This message is ignored.")
log~info("This message is ignored.")
log~warn("This is a warning.")
log~error("This is an error.")
log~fatal("This is a fatal error.")

exit

::requires 'TinyLog'
