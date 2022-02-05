// Loader ELF to load shellcodes from a file

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/mman.h>

#define USAGE                                        \
    "usage: loader FILE\n"                           \
    "\n"                                             \
    "Loads shellcode from a file and executes it.\n" \
    "\n"                                             \
    "positional arguments:\n"                        \
    " FILE        path to shellcode file"            \

#define print_err(string, ...)                          \
    do                                                  \
    {                                                   \
        fprintf(stderr, "[!] %s: %s @ %d: " string,     \
                __FILE__,                               \
                __FUNCTION__,                           \
                __LINE__,                               \
                ##__VA_ARGS__);                         \
    } while (0)

int main(int argc, char** argv) {
    // User should provide FILE argument
    if (2 != argc) {
        puts(USAGE);
        return -1;
    }

    // Check to see if FILE exists
    struct stat stat_buf = {0};
    if (0 != stat(argv[1], &stat_buf)) {
        print_err("Unable to find FILE provided: %s\n", argv[1]);
        puts(USAGE);
        goto CLEANUP;
    }

    // Allocate rwx segment to load shellcode into
    char* shellcode_segment = (char*) mmap(0, stat_buf.st_size, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANON, -1, 0);
    if (NULL == shellcode_segment) {
        int errnum = errno;
        print_err("Failed to mmap segment for shellcode, errno: %d\n", errnum);
        goto CLEANUP;
    }

    // Open FILE
    FILE* shellcode_file = fopen((const char*) argv[1], "r");
    if (NULL == shellcode_file) {
        int errnum = errno;
        print_err("Failed to open shellcode file: %s, errno: %d\n", argv[1], errnum);
        goto CLEANUP;
    }

    // Read FILE contents into shellcode_segment
    int bytes_read = 0;
    while(!feof(shellcode_file)) {
        bytes_read = fread(&shellcode_segment[bytes_read], stat_buf.st_size - bytes_read, 1, shellcode_file);
        if (0 > bytes_read) {
            int errnum = errno;
            print_err("Failed to read from file: %s, errno: %d\n", argv[1], errnum);
            goto CLEANUP;
        }
    }

    // Close FILE
    if (0 > fclose(shellcode_file)) {
        int errnum = errno;
        print_err("Failed to close file: %s, errno: %d\n", argv[1], errnum);
        goto CLEANUP;
    }

    // Execute shellcode
    ((void(*)()) shellcode_segment)();

    // Free shellcode_segment
    free(shellcode_segment);
    return EXIT_SUCCESS;

CLEANUP:
    if (shellcode_segment) {
        free(shellcode_segment);
    }
    if (shellcode_file) {
        fclose(shellcode_file);
    }
    return EXIT_FAILURE;
}