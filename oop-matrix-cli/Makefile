CC=zig cc
CXX=zig c++
RM=rm -f
# CPPFLAGS=-g $(shell root-config --cflags)
# LDFLAGS=-g $(shell root-config --ldflags)
# LDLIBS=$(shell root-config --libs)

SRCS=tool.cc
OBJS=$(subst .cc,.o,$(SRCS))

all: tool

tool: $(OBJS)
	$(CXX) -o tool $(OBJS)

debug: $(OBJS)
	$(CXX) -o tool_debug $(OBJS) -DDEBUG_VALUES

test:
	$(CXX) tool_test.cc -I. -WL -o tool_test
	./tool_test --cester-minimal

clean:
	$(RM) $(OBJS)
