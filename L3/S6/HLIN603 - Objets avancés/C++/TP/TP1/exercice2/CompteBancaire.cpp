#include <iostream>

#include "CompteBancaire.hpp"

CompteBancaire::~CompteBancaire()
{
    std::cout << "solde: " << _solde;
}

void CompteBancaire::deposer(float montant)
{
    _solde += montant;
}
