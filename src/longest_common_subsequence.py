"""最长公共子序列"""


def longest_common_subsequence(nums_a, nums_b):
    m, n = len(nums_a), len(nums_b)
    table = [[0] * (n + 1) for i in range(m + 1)]

    for i in range(1, m + 1):
        for j in range(1, n + 1):
            func_f(i, j, table, nums_a, nums_b)

    return table[m][n]


def func_f(index_a, index_b, table, nums_a, nums_b):

    if nums_a[index_a - 1] == nums_b[index_b - 1]:
        before = table[index_a - 1][index_b - 1]
        table[index_a][index_b] = before + 1
    else:
        value = max(table[index_a - 1][index_b], table[index_a][index_b - 1])
        table[index_a][index_b] = value


if __name__ == '__main__':
    longest_common_subsequence("pmjghexybyrgzczy", "hafcdqbgncrcbihkd")
