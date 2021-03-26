#pragma once

#include <iostream>
#include <string>
#include <string_view>

class Verse {
public:
    std::string_view getString() const;
    void setString(std::string_view string);

    std::string_view getRhyme() const;
    void setRhyme(std::string_view rhyme);

    void input(std::istream& is);
    void display(std::ostream& os) const;

private:
    std::string string_;
    std::string rhyme_;
};
