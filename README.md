# shellcodes
Custom shellcodes, free for use.

## Purpose

The purpose of this repository is to store custom shellcodes that I can't seem
to find via Google-searching, other open source projects, pwnlib shellcode
auto-generation, etc.

Currently, this repository only contains shellcodes to execute a single command
on a remote target across multiple different architectures. There are plenty of
methods to write shellcode in C, however, conducting program counter based
jumps to store strings in registers seems easier to do in assembly.

## Contributing

Obtaining shellcode execution on a target to then execute a `system` command
via `/bin/sh` has been effective enough for me, historically, to execute
follow-on payloads by uploading them to the target via `wget` or `curl`. If you
see the need for more complex shellcodes, feel free to submit a pull request.
