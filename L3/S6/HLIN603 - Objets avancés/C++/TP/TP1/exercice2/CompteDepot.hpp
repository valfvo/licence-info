#pragma once

#include "CompteBancaire.hpp"

class CompteDepot : CompteBancaire {
public:
    ~CompteDepot() override;
    void deposer(float montant) override;
};
