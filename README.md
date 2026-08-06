# oorexx-tinylog

<p align="center">
  <img src="resources/logo.svg" alt="oorexx-tinylog logo" width="210">
</p>

A tiny logging library for Open Object Rexx.

## Description

A lightweight logging library providing six log levels, optional colored console output, optional file logging, and extensible formatting and output for [Open Object Rexx](https://sourceforge.net/projects/oorexx/files/).

TinyLog is deliberately small. However, it allows for extensibility via `call` for formatting and `say` for output.

## Features

- **Zero-Friction Start**, High Extensibility: works right out of the box with zero setup for beginners, but can be extended effortlessly.
- 6 Log Levels: Full support for standard logging levels (`TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`) with configurable minimum-level threshold filtering.
- Optional ANSI Colored Console Output.
- Flexible Output Destinations: Send logs to:
  - Standard console output (`.output`).
  - Log files (simply pass a file path string).
  - Thread-safe `.Monitor` objects.
  - Any custom object responding to the `SAY` method.
- Custom Formatters: Easily attach custom formatting logic by assigning any object that implements a `call` method.

## When to use TinyLog

TinyLog is designed for applications that need a simple, lightweight logging solution with minimal setup and easy extensibility.

If your project requires a full-featured, mature logging framework with advanced capabilities, consider using **log4rexx**, which is included in the [net-oo-rexx](https://github.com/RexxLA/net-oo-rexx) project.

## Requirements

- [Open Object Rexx](https://sourceforge.net/projects/oorexx/) 5.x

## Installation

Copy `TinyLog.rex` to a directory included in your `REXX_PATH` (or `PATH`) and import it using the `requires` directive:

~~~rexx
::requires 'TinyLog'
~~~

Alternatively, load it as an external routine:

~~~rexx
call 'TinyLog'
~~~

## Quick Start for beginners

### 10 seconds Quick Start

~~~rexx
log = .Logger~new() -- logs to .output
log~info("Hello!")

::requires 'TinyLog'
~~~

### Full basic API

~~~rexx
log = .Logger~new("text.log") -- logs to file "text.log"

-- Minimum log level threshold
log~level = 'INFO'

-- Disable ANSI colors for .output
log~usecolors = .false

-- Log messages at different levels
log~trace("This is ignored") -- TRACE < INFO
log~debug("This is ignored") -- DEBUG < INFO
log~info("Some information")
log~warn("Be careful!")
log~error("Something bad happened!")
log~fatal("Something REALLY bad happened!")

::requires 'TinyLog'
~~~

## Quick Start for advanced users

### Custom formatter

You can customize log formatting by using **any object** that implements a `call` method, which accepts a `record` `Directory` object as its argument and returns a formatted `String`.

~~~rexx
log = .Logger~new()
log~usecolors = .false
log~formatter = .MyFormatter~new
log~info('Some information')

::requires 'TinyLog'

::class MyFormatter

::method call
  use arg record

  -- record is a Directory object
  -- that contains log information

  logDate   = record~date
  logTime   = record~time
  level     = record~level
  source    = record~source
  line      = record~line
  message   = record~message
  usecolors = record~usecolors

  log = 'Level:' level || .endofline -
        '  Date:' logDate || .endofline -
        '  Time:' logTime || .endofline -
        '  File:' source || .endofline -
        '  Line:' line || .endofline -
        '  Message:' message

  if \usecolors then do
    log = log || .endofline -
          "  User doesn't like colors!"
    end

  return log
~~~

## Custom output

You can send log records to any custom destination by using **any object** that implements a `say` method, which accepts a formatted String line as its argument (and does not need to return a value).

~~~rexx
log = .Logger~new()

mbo = .MutableBufferOutput~new()
log~output = mbo

do i = 1 to 10
  log~info('Some information')
end

say 'Waiting...'
parse pull .

say mbo~mb~string

::requires 'TinyLog'

::class MutableBufferOutput

::method mb
  expose mb
  return mb

::method init
  expose mb
  mb = .MutableBuffer~new

::method say
  expose mb
  use arg str
  mb~append(str, .endofline)
~~~

## Examples

The `examples/` directory contains runnable examples demonstrating the library's main features.

### Getting started

1. `examples/basic.rex`: Getting started.
2. `examples/levels.rex`: Log level filtering.

### Customization and integration

1. `examples/custom_formatter.rex`: Custom formatting.
2. `examples/outputs.rex`: Alternative output destinations.
3. `examples/json_socket.rex`: Structured JSON logging over TCP.
4. `examples/syslog.rex`: Logging to a Syslog server.
5. `examples/rotate_log.rex`: Log file rotation.

## API Reference

### `Logger` class

Creates a new logger.

```rexx
log = .Logger~new([output])
```

The optional `output` argument may be:

- A `String` containing a file path. The file is opened automatically.
- A `.Monitor` object.
- Any object implementing a `say` method.
- Omitted, in which case logs are written to `.output`.

### Attributes

| Attribute   | Default   | Description                                                                          |
| ----------- | --------- | ------------------------------------------------------------------------------------ |
| `level`     | `'TRACE'` | Minimum log level. Messages below this level are ignored.                            |
| `usecolors` | `.true`   | Enables ANSI-colored output on the console.                                          |
| `output`    | `.output` | Secondary output destination.                                                        |
| `formatter` | `.nil`    | Custom formatter object. When `formatter` is `.nil`, the built-in formatter is used. |

### Log methods

The logger provides one method for each log level:

```rexx
log~trace(...)
log~debug(...)
log~info(...)
log~warn(...)
log~error(...)
log~fatal(...)
```

Each method accepts any number of arguments. The arguments are stored in the log record (`record~args`) and their string representation is available as `record~message`.

### Log levels

Supported log levels, in ascending order of severity:

| Level   | Description                                       |
| ------- | ------------------------------------------------- |
| `TRACE` | Detailed diagnostic information.                  |
| `DEBUG` | Debugging information.                            |
| `INFO`  | Informational messages.                           |
| `WARN`  | Warning conditions.                               |
| `ERROR` | Error conditions.                                 |
| `FATAL` | Severe errors that may terminate the application. |

### Record fields

A formatter receives a `Directory` with the following entries:

| Field | Description |
|-------|-------------|
| `date` | Date (`= date('S')`) |
| `time` | Time (`= time()`) |
| `level` | Level name |
| `level_number` | Numeric level |
| `message` | Formatted message |
| `args` | Original arguments |
| `source` | Source file |
| `line` | Source line |
| `usecolors` | ANSI colors enabled (`.true`|`.false`) |
| `context` | The caller's Rexx execution context. It can be used for advanced introspection. |

### Formatters

A formatter converts a log record into a `String`.

Any object implementing a `call(record)` method can be used as a formatter. The method receives a `Directory` containing the log record and must return a formatted string.

### Outputs

An output receives formatted log messages and sends them to their final destination.

Any object implementing a `say(string)` method can be used as an output.

```rexx
log~output = .MyOutput~new
```

## License

Distributed under the terms of the [LICENSE](LICENSE) file.

## Author

Salvador Parra Camacho

GitHub: https://github.com/sparrac
