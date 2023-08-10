"""
下降路径最小和II
给你一个 n x n 整数矩阵 grid ，请你返回 非零偏移下降路径 数字和的最小值。

非零偏移下降路径 定义为：从 grid 数组中的每一行选择一个数字，且按顺序选出来的数字中，相邻数字不在原数组的同一列

我们定义 f[i][j]f[i][j]f[i][j] 表示前 iii 行，且最后一个数字在第 jjj 列的最小数字和。那么状态转移方程为：
"""


def min_falling_path_sum(grid):
    n = len(grid)
    if n == 1:
        return grid[0][0]
    dp = [[0]*n for i in range(n + 1)]
    for i in range(1, n + 1):
        for j in range(n):
            dp_func(dp, i, j, grid, n)
    return min(dp[n])


def dp_func(dp, row, col, grid, col_num):
    if col != 0:
        min_n = dp[row-1][0]
    else:
        min_n = dp[row-1][1]

    for k in range(col_num):
        if k != col:
            min_n = min(min_n, dp[row - 1][k])
    dp[row][col] = grid[row - 1][col] + min_n
