#pragma once

#include <iostream>
#include <vector>

#include "Verse.hpp"

class Stanza {
public:
    Verse getVerse(int i);

    void input(std::istream& is);
    void display(std::ostream& os) const;

private:
    std::vector<Verse> verses_;
};
