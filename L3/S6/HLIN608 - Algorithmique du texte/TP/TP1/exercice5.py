def recherche_naive(motif, texte):
    pos_motif = []
    n = len(texte)
    m = len(motif)
    for i in range(n - m):
        j = 0
        while j < m and texte[i+j] == motif[j]:
            j += 1
        if j == m:
            pos_motif.append(i)
    return pos_motif

print(recherche_naive('baignoire', 'La baignoire est dans le sac des baignoires'))
