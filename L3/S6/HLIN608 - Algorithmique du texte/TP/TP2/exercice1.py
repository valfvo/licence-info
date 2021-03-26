deletion = 3
insertion = 3

def sub(a, b):
    return 0 if a == b else 3

def calcul_generique(x, y, mode='score'):
    m = len(x)
    n = len(y)
    T = [[0 for col in range(n+1)] for row in range(m+1)]
    T[0][0] = 0
    for i in range(1, m+1):
        T[i][0] = T[i-1][0] + deletion
    for j in range(1, n+1):
        T[0][j] = T[0][j-1] + insertion
        for i in range(1, m+1):
            f = max if mode == 'score' else min
            T[i][j] = f(T[i-1][j-1] + sub(x[i-1], y[j-1]),
                          T[i-1][j] + deletion,
                          T[i][j-1] + insertion)
    return T

# x = 'ACGGCTATC'
x = 'GATC'
# y = 'ACTGTAATG'
y = 'GGCTGAC'

T = calcul_generique(x, y, 'distance')

print(' ' * 5, '  '.join(list(y)), '\n  ', end='')
for i, col in enumerate(T):
    for c in col:
        if 0 <= c <= 9:
            print(f' {c} ', end='')
        else:
            print(f'{c} ', end='')
    if i < len(x):
        print(f'\n{x[i]} ', end='')
print()

print(T[len(x)][len(y)])

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

RED = '\033[91m'
GREEN = '\033[92m'
BLUE = '\033[94m'
RESET = '\033[0m'

for a, b in z:
    if a == b:
        print(GREEN + a + RESET, end='')
    elif a != '-' and b != '-':
        print(RED + a + RESET, end='')
    else:
        print(BLUE + a + RESET, end='')
    print(' ', end='')
print()

for i, j in z:
    print(GREEN + '| ' + RESET if i == j else '  ', end='')
print()

for a, b in z:
    if a == b:
        print(GREEN + b + RESET, end='')
    elif a != '-' and b != '-':
        print(RED + b + RESET, end='')
    else:
        print(BLUE + b + RESET, end='')
    print(' ', end='')
print()
