#pragma once

#include "CompteBancaire.hpp"

class CompteRemunere : CompteBancaire {
public:
    ~CompteRemunere() override;
    void deposer(float montant) override;

private:
    static const float _interet;
    static const float _interet_depot;
};
