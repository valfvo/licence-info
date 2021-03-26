# Exercice 1

u = input('u = ')
v = input('v = ')
print('uv = ' + u + v)
print('u barre = ' + u[::-1])
print('v barre = ' + v[::-1])

if len(u) <= len(v):
    print(''.join([w + v[i] for (i, w) in enumerate(u)]) + v[len(u):])
else:
    print(''.join([u[i] + w for (i, w) in enumerate(v)]) + u[len(v):])
