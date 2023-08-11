"""完全平方数"""
import math


def num_squares(n):
    dp = [0 for i in range(n + 1)]
    for j in range(1, n + 1):
        l, r = 1, int(math.sqrt(j))
        min_n = dp[j - 1]
        for i in range(l, r + 1):
            index = j - i * i
            min_n = min(min_n, dp[index])
        dp[j] = min_n + 1
    return dp[-1]

if __name__ == '__main__':
    r = num_squares(43)
    print(r)
