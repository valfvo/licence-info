# Exercice 1

filename = input('input filename: ')
with open(filename, 'r') as file:
    u, v = file.readline().split()

with open('output.txt', 'w') as file:
    file.write('uv = ' + u + v + '\n')
    file.write('u barre = ' + u[::-1] + '\n')
    file.write('v barre = ' + v[::-1] + '\n')

    if len(u) <= len(v):
        uv = ''.join([w + v[i] for (i, w) in enumerate(u)]) + v[len(u):]
        file.write(uv + '\n')
    else:
        uv = ''.join([w + v[i] for (i, w) in enumerate(u)]) + v[len(u):]
        file.write(uv + '\n')
