#include <iostream>

#include "Stanza.hpp"

void Stanza::input(std::istream& is)
{
    int size;
    is >> size;
    is.ignore(1);  // '\n'

    verses_.clear();
    verses_.reserve(size);

    for (int i = 0; i < size; ++i) {
        Verse verse;
        verse.input(is);
        verses_.push_back(verse);
    }
}

Verse Stanza::getVerse(int i)
{
    return verses_.at(i);
}

void Stanza::display(std::ostream& os) const
{
    for (const Verse& verse : verses_) {
        verse.display(os);
    }
}
