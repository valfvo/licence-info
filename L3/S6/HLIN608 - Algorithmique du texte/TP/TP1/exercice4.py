def fibonacci(n):
    l = ['', 'b', 'a']
    for i in range(3, n+1):
        l.append(l[i-1] + l[i-2])
    return l

def nthFibonacci(n):
    if n <= 2:
        return ['', 'b', 'a'][n]
    else:
        n2 = 'b'
        n1 = 'a'
        fib = ''
        for i in range(3, n+1):
            fib = n1 + n2
            n2 = n1
            n1 = fib
        return fib

def nthFibonacciRec(n):
    if n <= 2:
        return ['', 'b', 'a'][n]
    else:
        return nthFibonacciRec(n-1) + nthFibonacciRec(n-2)

print(fibonacci(6))
print(nthFibonacci(6))
print(nthFibonacciRec(6))
