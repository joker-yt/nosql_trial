SRC=01.cpp
OBJS=$(subst .cpp,.o,$(SRC))
EXE=$(subst .cpp,.bin,$(SRC))
CPPFLAGS=-std=c++11 -MMD -g
DEPS=$(subst .cpp,.h,$(SRC))
INCLUDE=-I/usr/include/mongo
LDFLAGS=-lpthread
LDFLAGS+=-lmongoclient
LDFLAGS+=-lboost_thread-nt
LDFLAGS+=-lboost_system
LDFLAGS+=-lboost_regex
## If you need PNG files by plantuml
# UML=01-02_01.uml 01-03_01.uml
# PNG=$(subst .uml,.png,$(UML))
# PLANTUML=~/plantuml.jar
# PLANTUMLFLAGS=-jar $(PLANTUML)
# PNG_DIR=`pwd`/pics

CXX=g++

# Phony is the rule that doesn't have any "target".
.PHONY: all clean check-syntax
all: $(EXE)
-include $(DEPS)

# Suffixes is needed for the rule of exchanging extentions
.SUFFIXES:	.cpp .bin
.cpp.bin:
	g++ $< -o $@ $(CPPFLAGS) $(LDFLAGS)

# for make shared library
#.cpp.o
# real name: libfoo.so
# soname: libbar.so
# TARGET -> realname
# g++ -fPIC $< -o $@ $(CPPFLAGS)
# g++ -o TARGET -shared -Wl,-soname,libbar.so *.o
# g++ -o TARGET -shared -Wl,-rpath,/home/hoge/lib *.o <- instead of LD_LIBRARY_PATH

# .uml.png:
# 	mkdir -p $(PNG_DIR)
# 	java $(PLANTUMLFLAGS) -o $(PNG_DIR) $<

clean:
	rm -fr *.o *.gch *.d *.bin *.png

check-syntax:
	$(CXX) -o null -fsyntax-only $(CHK_SOURCES) $(INCLUDES) $(CPPFLAGS)
