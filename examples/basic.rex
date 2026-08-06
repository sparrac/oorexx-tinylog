#!/usr/bin/env rexx
-- basic.rex
-- Minimal example using the default logger.

parse arg usecolors

log = .Logger~new('basic.log')

if usecolors = .true | usecolors = .false then
  log~usecolors = usecolors

log~trace("trace")
log~debug("debug")
log~info("info")
log~warn("warn")
log~error("error")
log~fatal("fatal")

exit

::requires 'TinyLog'
