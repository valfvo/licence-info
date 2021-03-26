def prefixe(u, v):
    return u == v[:len(u)]

def suffixe(u, v):
    return u == v[len(v) - len(u):]

def bords(u):
    return [u[:i] for i in range(len(u)) if suffixe(u[:i], u)]

print(prefixe('ab', 'abac'))
print(suffixe('a', 'bcda'))
print(bords('aabaaabaa'))
