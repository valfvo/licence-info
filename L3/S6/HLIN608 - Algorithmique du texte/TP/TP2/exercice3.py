deletion = -1
insertion = -1

def sub(a, b):
    return 2 if a == b else -1

def calcul_generique(x, y, mode='score'):
    m = len(x)
    n = len(y)
    T = [[0 for col in range(n+1)] for row in range(m+1)]
    for i in range(m+1):
        T[i][0] = 0
    for j in range(1, n+1):
        T[0][j] = 0
        for i in range(1, m+1):
            f = max if mode == 'score' else min
            T[i][j] = f(T[i-1][j-1] + sub(x[i-1], y[j-1]),
                        T[i-1][j] + deletion,
                        T[i][j-1] + insertion,
                        0)
    return T

# x = 'ACGGCTATC'
x = 'GATCACTTCCATG'
# y = 'ACTGTAATG'
y = 'GGCTGACCACCTT'

T = calcul_generique(x, y)

print(f'      {"  ".join(list(y))}\n  ', end='')
for i, row in enumerate(T):
    for col in row:
        if 0 <= col <= 9:
            print(' ', end='')
        print(f'{col} ', end='')
    if i < len(x):
        print(f'\n{x[i]} ', end='')
print()

print(f'\nScore: {T[len(x)][len(y)]}\n')

def un_alignement(x, y, T):
    m = len(x)
    n = len(y)
    z = []
    i = m
    j = n
    while i != 0 and j != 0:
        if T[i][j] == T[i-1][j-1] + sub(x[i-1], y[j-1]):
            z.insert(0, [x[i-1], y[j-1]])
            i -= 1
            j -= 1
        elif T[i][j] == T[i-1][j] + deletion:
            z.insert(0, [x[i-1], '-'])
            i -= 1
        else:
            z.insert(0, ['-', y[j-1]])
            j -= 1
    while i != 0:
        z.insert(0, [x[i-1], '-'])
        i -= 1
    while j != 0:
        z.insert(0, ['-', y[j-1]])
        j -= 1
    return z

z = un_alignement(x, y, T)

print(' '.join([i[0] for i in z]))
for i, j in z:
    print('| ' if i == j else '  ', end='')
print()
print(' '.join([i[1] for i in z]))
