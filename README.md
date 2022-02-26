# shellcodes
Custom shellcodes, free for use.

## Purpose

The purpose of this repository is to store custom shellcodes that I can't seem
to find via Google-searching, other open source projects, pwnlib shellcode
auto-generation, etc.

Currently, this repository only contains shellcodes to execute a single command
on a remote target across multiple different architectures. There are plenty of
methods to write shellcode in C, however, conducting relative jumps to store
strings in registers seems easier to do in assembly.

## Building shellcodes

I provide a `build.sh` script in the root of this repository. Running it like
so should provide you with an assembled shellcode for each supported
architecture:

```bash
./build.sh
```

## Using system shellcodes

The shellcodes provided are designed to execute the following command on Linux
targets:

```bash
/bin/sh -c "<your command here>"
```

To add your command to a shellcode, run the following command from the root of
this repo:

```bash
echo -ne "<your command here>" | cat src/<arch>-system.bin - > shellcode
```

The file `shellcode` will now contain the system shellcode, appended with your
command.

## Testing shellcodes

The provided `build.sh` script also compiles the `loader.c` ELF for each
supported architecture. Given a target shellcode file, the `loader` ELF will
read and execute your shellcode file for testing.

## Contributing

Obtaining shellcode execution on a target to then execute a `system` command
via `/bin/sh` has been effective enough for me, historically, to execute
follow-on payloads by uploading them to the target via `wget` or `curl`. If you
see the need for more complex shellcodes, feel free to submit a pull request.
