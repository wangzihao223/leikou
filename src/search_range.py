"""在排序数组中查找元素的第一个和最后一个位置"""

"""
nums = [5,7,7,8,8,10], target = 8
[8, 8, 8, 8, 8]
"""


def find_num(nums, target):
    length = len(nums)

    left = 0
    right = length - 1

    while right >= left:
        k = (right + left) // 2
        if nums[k] == target:
            return left, right, k
        elif nums[k] < target:
            # target on right
            left = k + 1
        else:
            # on left
            right = k - 1
    if right < left:
        return None


def find_left(nums, left, right, target):
    while right >= left:
        k = (right + left) // 2
        if nums[k] == target:
            right = k - 1
        else:
            left = k + 1

    if right < left:
        return left


def find_right(nums, left, right, target):
    while right >= left:
        k = (right + left) // 2
        if nums[k] == target:
            left = k + 1
        else:
            right = k - 1

    if right < left:
        return right


def main(nums, target):
    tp = find_num(nums, target)
    if tp is None:
        return [-1, -1]
    left, right, k = tp
    if k - 1 >= left:
        left_index = find_left(nums, left, k - 1, target)
    else:
        left_index = k

    if k + 1 <= right:
        right_index = find_right(nums, k + 1, right, target)
    else:
        right_index = k

    return [left_index, right_index]
