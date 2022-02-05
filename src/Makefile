include $(arch).mk

all: $(arch)-system.bin

%.o: %.S
	$(CC) $(CFLAGS) -o $@ $<

$(arch)-system.bin: $(arch)-system.o
	$(OBJCOPY) $(OBJCOPYFLAGS) $< $@

clean:
	@rm -rf $(arch)-system.bin
	@rm -rf $(arch)-system.o
