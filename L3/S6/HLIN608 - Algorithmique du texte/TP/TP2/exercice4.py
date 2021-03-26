def alignement(x, y, o, e, s, mode='score'):
    m = len(x)
    n = len(y)

    M = [[0 for col in range(n+1)] for row in range(m+1)]
    D = [[0 for col in range(n+1)] for row in range(m+1)]
    I = [[0 for col in range(n+1)] for row in range(m+1)]
    M[0][0] = D[0][0] = I[0][0] = 0

    for i in range(1, m+1):
        M[i][0] = D[i][0] = I[i][0] = -o - (i-1) * e

    for j in range(1, n+1):
        M[0][j] = D[0][j] = I[0][j] = -o - (j-1) * e
        for i in range(1, m+1):
            f = max if mode == 'score' else min
            M[i][j] = f(M[i-1][j-1] + s(x[i-1], y[j-1]),
                        D[i-1][j-1] + s(x[i-1], y[j-1]),
                        I[i-1][j-1] + s(x[i-1], y[j-1]))

            D[i][j] = f(M[i-1][j] - o,
                        D[i-1][j] - e)

            I[i][j] = f(M[i][j-1] - o,
                        I[i][j-1] - e)
    return [M, D, I]

x = 'CTA'
y = 'CTGACAT'

def print_matrix(x, y, m):
    col_width = max(len(str(col)) for row in m for col in row) + 1
    print(' ' * (2 * col_width)
          + (' ' * (col_width - 1)).join(list(y))
          + '\n ', end='')
    for i, row in enumerate(m):
        for col in row:
            print(' ' * (col_width - len(str(col))) + str(col), end='')
        if i < len(x):
            print(f'\n{x[i]}', end='')
    print()

s = lambda a, b: -1 if a != b else 2
for m in alignement(x, y, 3, 1, s, 'score'):
    print_matrix(x, y, m)
    print()
