"""二叉树展开为链表"""


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def flatten(root):
    preorder(root, None)

def preorder(root, last_point):
    if root is None:
        return last_point
    point = preorder(root.left, root)
    point.right = root.right
    root.right = root.left
    root.left = None
    preorder(root.right, root)
