import numpy as np
a = np.array(['apples', 'foobar', 'cowboy'])
a[2] = 'bananas'
print(a[0])
print(a[1])
print(a[2])
print("...")
print(a[-1])
print("...")
print(a[:])
print("...")
print(a)

b = np.empty(3, dtype = "S3")
b[:] = '0'
b[2] = '3'
b[1] = 5
print(b)
print(str(b[2]))
print(int(b[2]))
print(str(b[1]))
print(int(b[1]))
print(b[0] == b'0')
print(b[2] == '3')

x = ['0'] * 5
print(x)

string = "Python is interesting."

# string with encoding 'utf-8'
arr = bytearray(string, 'utf-8')
print(arr)
