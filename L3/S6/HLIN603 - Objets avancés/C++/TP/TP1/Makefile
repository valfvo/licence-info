CXX = g++
CXXFLAGS = -Wall -Wextra -Wfatal-errors -std=c++17 -MMD

SRC = $(wildcard */*.cpp)
OBJ = $(SRC:.cpp=.o)

EXE_SRC = $(wildcard */exercice*.cpp)
EXE = $(EXE_SRC:.cpp=.exe)

all: $(EXE)

define build_exe
$(1): $(patsubst %.cpp,%.o,$(wildcard $(dir $(1))*.cpp))
	$(CXX) $(CXXFLAGS) $$^ -o $$@
endef

$(foreach exe,$(EXE),$(eval $(call build_exe,$(exe))))

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

-include $(OBJ:.o=.d)

.PHONY: clean

clean:
	rm -f */*.exe
	rm -f */*.o
	rm -f */*.d
