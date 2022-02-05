include $(arch).mk
LOADER:="loader.c"

all: $(arch)-loader

$(arch)-loader:
	$(CC) $(CFLAGS) -o $@ $(LOADER)

clean:
	@rm -rf $(arch)-loader
