CC      = m68k-amigaos-gcc
CFLAGS  = -noixemul -O2 -Wall
TARGET  = window
OBJS    = window.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET) $(TARGET).lha

# Bygg en Amiga-vänlig LHA för Workbench
dist: $(TARGET)
	lha a $(TARGET).lha $(TARGET)
