"""打家结舍"""


def rob(nums):
    n = len(nums)
    if n == 1:
        return nums[0]
    if n == 2:
        return max(nums)

    dp = [0 for i in range(n + 1)]

    dp[1] = nums[0]
    dp[2] = max(nums[0], nums[1])

    for i in range(3, n + 1):
        dp[i] = max(dp[i - 2] + nums[i - 1], dp[i-1])

    print(dp)
    return dp[-1]

if __name__ == '__main__':
    rob([1,3,1,3,100])