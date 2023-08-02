import random


def get_k_e(k, n1, n2):
    l1 = len(n1)
    l2 = len(n2)
    i1 = 0
    i2 = 0

    while True:
        if i1 == l1:
            return n2[i2 + k - 1]
        if i2 == l2:
            return n1[i1 + k - 1]
        if k == 1:
            return min(n1[i1], n2[i2])

        b1 = min(i1 + k // 2 - 1, l1-1)
        b2 = min(i2 + k // 2 - 1, l2-1)
        if n1[b1] >= n2[b2]:
            k -= b2 - i2 + 1
            i2 = b2 + 1
        else:
            k -= b1 - i1 + 1
            i1 = b1 + 1


def main(n1, n2):
    l = len(n1) + len(n2)
    if l % 2 != 0:
        return get_k_e((l+1)//2, n1, n2)
    else:
        return (get_k_e((l+1)//2, n1, n2) + get_k_e((l+1)//2+1, n1, n2)) / 2




if __name__ == '__main__':
    r = main([1,2,3,4,5], [6 ,7, 8, 9])
    print(r)