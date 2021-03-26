#include "CompteDepot.hpp"

CompteDepot::~CompteDepot()
{
    _solde -= 100;
}

void CompteDepot::deposer(float montant)
{
    montant -= 1;
    if (montant > 1000)
        montant += 10;
    CompteBancaire::deposer(montant);
}
