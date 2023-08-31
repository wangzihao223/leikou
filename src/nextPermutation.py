# 下一个排列算法

def next_permuation(nums):
    length = len(nums)
    # for i in range(length - 1, 0, -1):
    i = length - 2
    while i >=0 and  nums[i] >= nums[i + 1]:
        i -= 1
    if i >= 0:
        k = find_k(i + 1, nums[i], nums, length)
        nums[k], nums[i] = nums[i], nums[k]
    reverse(i + 1, length, nums) 

def find_k(j, n, nums, len):
    for k in range(len - 1, j - 1, -1):
        if nums[k] > n:
            return k

def reverse(j, len, nums):
    x = j
    y = len - 1
    while  y > x:
        nums[x], nums[y] = nums[y], nums[x]
        x += 1
        y -= 1
nums = [1,1,5]
next_permuation(nums)
print(nums)