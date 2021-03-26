#include "CompteRemunere.hpp"

const float CompteRemunere::_interet = 0.1;
const float CompteRemunere::_interet_depot = 0.01;

CompteRemunere::~CompteRemunere()
{
    _solde *= 1 + _interet;
}

void CompteRemunere::deposer(float montant)
{
    CompteBancaire::deposer(montant * (1 + _interet_depot));
}
