CC=zig cc
CXX=zig c++
RM=rm -f
# CPPFLAGS=-g $(shell pkg-config --cflags cppunit)
# LDLIBS=$(shell pkg-config --libs cppunit)

SRCS=tool.cc main.cc
TEST_SRCS=tool.cc tool_test.cc
OBJS=$(subst .cc,.o,$(SRCS))

all: tool

tool: $(OBJS)
	$(CXX) -o tool $(OBJS)
	# $(CXX) $(CPPFLAGS) -o tool $(OBJS) $(LDLIBS)

debug: $(OBJS)
	$(CXX) -o tool_debug $(OBJS) -DDEBUG_VALUES
	# $(CXX) $(CPPFLAGS) -o tool_debug $(OBJS) $(LDLIBS) -DDEBUG_VALUES

test:
	$(CXX) $(TEST_SRCS) -o tool_test
	./tool_test

format:
	clang-format -i *.cc *.hh

clean:
	$(RM) $(OBJS)
