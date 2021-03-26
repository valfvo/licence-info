#include <iostream>

#include "Stanza.hpp"
#include "Verse.hpp"

int main() {
    Stanza stanza;

    std::cout << "number of verses: ";
    stanza.input(std::cin);

    std::cout << "\nyour stanza:\n";
    stanza.display(std::cout);

    return 0;
}
