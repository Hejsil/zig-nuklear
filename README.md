# zig-nuklear

WIP bindings for [Nuklear](https://github.com/Immediate-Mode-UI/Nuklear).

## Goals

* Provide an API simular to Nuklear, but with improvements thrown in where it makes
  sense.
* Support using Nuklear with or without libc.
  * Provide default implementations for overridable Nuklear function in Zig if libc is
    unwanted.
* Have a few backends that don't depend on any system libraries (exept the basic
  libraries all programs depend on for that system).
  * By doing this, we get easy cross compilation!

## TODO:

* [ ] Provide wrappers for all ui functions provided by Nuklear
* [ ] Provide a few backends with minimal system dependencies:
  * [ ] Windows (using gdi)
  * [ ] Linux (x11, maybe wayland)

