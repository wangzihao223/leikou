# 寻找重复数
def find_duplicate(nums):
    slow, fast = 0,0
    while True:
        slow = nums[slow]
        fast = nums[nums[fast]]
        if fast == slow:
            break
    ptr = 0
    while ptr != slow:
        slow = nums[slow]
        ptr = nums[ptr]
    return ptr

r = find_duplicate([3,1,3,4,2])
print(r)