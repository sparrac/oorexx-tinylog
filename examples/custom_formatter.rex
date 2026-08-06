#!/usr/bin/env rexx
-- custom_formatter.rex
-- Example using a custom formatter.

log = .Logger~new()

log~formatter = .routines['EMOJIFORMATTER']

log~trace("trace")
log~debug("debug")
log~info("info")
log~warn("warn")
log~error("error")
log~fatal("fatal")

exit

::requires 'TinyLog'

::routine emojiFormatter
  use arg record

  LEVEL_EMOJIS = ('🔍', '🐞', '✅', '❗', '❌', '💀')
  emoji = LEVEL_EMOJIS[record~level_number]

  level_str = left(record~level, 5)

  log_str = emoji '['level_str,
            date('L', record~date, 'S') record~time']',
            record~source':'record~line,
            record~message

  return log_str
