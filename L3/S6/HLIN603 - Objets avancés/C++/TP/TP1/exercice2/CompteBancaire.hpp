#pragma once

class CompteBancaire {
public:
    virtual ~CompteBancaire();
    virtual void deposer(float montant);

protected:
    float _solde;
};
