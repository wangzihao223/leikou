

def moveZeroes(nums):
    i1 = 0
    i2 = 0
    l = len(nums)

    while i2 < l :
        if nums[i2] != 0:

            if i2 != i1:
                nums[i1], nums[i2] = nums[i2], nums[i1]
            i2 += 1
            i1 += 1
        else:
            i2 += 1
moveZeroes([1, 0 ,2 ,0, 3, 0, 1, 1, 1])