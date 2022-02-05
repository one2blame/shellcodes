CC = x86_64-linux-gnu-gcc
CFLAGS = -m64 -c -Wall
OBJCOPY = x86_64-linux-gnu-objcopy
OBJCOPYFLAGS = -S -O binary -j .text
