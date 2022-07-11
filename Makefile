BINARY=app

CODEDIRS=.
INCDIRS=.

CC=gcc
OPT=-O0

DEPFLAGS=-MP -MD

CFLAGS=-Wall -Wextra -Wshadow -g
CFLAGS+=$(shell pkg-config --cflags gtk4)
CFLAGS+=$(OPT) $(DEPFLAGS)
LFLAGS=$(shell pkg-config --libs gtk4)

CFILES=$(foreach D,$(CODEDIRS), $(wildcard $(D)/*.c))
OBJECTS=$(patsubst %.c,%.o,$(CFILES))
DEPFILES=$(patsubst %.c,%.d, $(CFILES))

all: $(BINARY)

$(BINARY): $(OBJECTS)
	$(CC) -o $@ $^ $(LFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $< $(LFLAGS)

clean:
	rm -rf $(BINARY) $(OBJECTS) $(DEPFILES)

-include $(DEPFILES)

.PHONY: clean
