#include <string>

#include "Verse.hpp"

std::string_view Verse::getString() const
{
    return string_;
}

void Verse::setString(std::string_view string)
{
    string_ = string;
}

std::string_view Verse::getRhyme() const
{
    return rhyme_;
}

void Verse::setRhyme(std::string_view rhyme)
{
    rhyme_ = rhyme;
}

void Verse::input(std::istream& is)
{
    std::getline(is, string_);
}

void Verse::display(std::ostream& os) const
{
    os << string_ << '\n';
}
