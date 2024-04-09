CC=zig cc
CXX=zig c++
RM=rm -f
# CPPFLAGS=-g $(shell pkg-config --cflags cppunit)
# LDLIBS=$(shell pkg-config --libs cppunit)

SRCS=tool.cc main.cc
HH=tool.hh
TEST_SRCS=tool.cc tool_test.cc
# OBJS=$(subst .cc,.o,$(SRCS))

all: tool

tool: $(SRCS)
	$(CXX) -o tool $(SRCS)

debug: $(SRCS)
	$(CXX) -o tool_debug $(SRCS) -DDEBUG_VALUES

test:
	$(CXX) $(TEST_SRCS) -o tool_test
	./tool_test

lint: $(SRCS) $(HH)
	cppcheck $(SRCS) $(HH) --std=c++17 --enable=all --suppress=missingIncludeSystem

format:
	clang-format -i *.cc *.hh

clean:
	$(RM) $(OBJS)
