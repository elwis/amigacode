# Makefile för Bjerins Amiga C exempel
# Använder amiga-gcc cross-compiler

# Compiler och verktyg
CC = ~/amiga-gcc/bin/m68k-amigaos-gcc
CFLAGS = -Wall -O2 -fomit-frame-pointer -m68000
LDFLAGS = -s

# Target executable
TARGET = program

# Source files
SOURCES = ModuleA.c ModuleB.c

# Object files (automatiskt genererade från källfiler)
OBJECTS = $(SOURCES:.c=.o)

# Default target
all: $(TARGET)

# Länka ihop objektfilerna till slutprogrammet
$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

# Kompilera .c filer till .o filer
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Rensa upp objektfiler och executable
clean:
	rm -f $(OBJECTS) $(TARGET)

# Rensa allt inkl backup-filer
distclean: clean
	rm -f *~ *.bak

# Visa info om targets
help:
	@echo "Available targets:"
	@echo "  all      - Kompilera och länka programmet"
	@echo "  clean    - Ta bort objektfiler och executable"
	@echo "  distclean- Ta bort allt inkl backup-filer"
	@echo "  help     - Visa denna hjälp"

# Säg åt make att dessa inte är filer
.PHONY: all clean distclean help
