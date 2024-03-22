CC=zig cc
CXX=zig c++
RM=rm -f
# CPPFLAGS=-g $(shell root-config --cflags)
# LDFLAGS=-g $(shell root-config --ldflags)
# LDLIBS=$(shell root-config --libs)

SRCS=main.cc
OBJS=$(subst .cc,.o,$(SRCS))

all: tool

tool: $(OBJS)
	# $(CXX) $(LDFLAGS) -o tool $(OBJS) $(LDLIBS)
	$(CXX) -o tool $(OBJS)

clean:
	$(RM) $(OBJS)
