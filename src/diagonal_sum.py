"""矩阵对角线元素的和"""


def diagonal_sum(mat):
    m = len(mat)
    if m == 1:
        return mat[0][0]
    i1, j1 = 0, 0
    i2, j2 = 0, m-1
    s = mat[0][0] + mat[0][m-1]
    for i in range(1, m):
        i1, j1 = i1 + 1, j1 + 1
        i2, j2 = i2 + 1, j2 - 1
        s += mat[i1][j1]
        s += mat[i2][j2]
        if i1 == i2 and j1 == j2:
            s -= mat[i2][j2]
    print(s)
    return s

if __name__ == '__main__':
    diagonal_sum([[1,1,1,1],
            [1,1,1,1],
            [1,1,1,1],
            [1,1,1,1]])
