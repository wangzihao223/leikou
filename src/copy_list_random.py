"""拷贝随机链表"""

class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = int(x)
        self.next = next
        self.random = random

def copy_node(copy):
    copy_point = copy

    while copy_point is not None:
        be_copy = copy_point.next
        if be_copy is not None:
            new_node = Node(be_copy.val, next=be_copy.next)
            be_copy.next = new_node
            copy_point = new_node
        else:
            copy_point = None

def find_random(source, copy):
    source_point = source
    copy_point = copy
    while source_point is not None:
        if source_point.random is not None:
            copy_point.random = source_point.random.next

        source_point = copy_point.next
        if source_point is not None:
            copy_point = source_point.next
        else:
            break

def split(source, copy):
    source_point = source
    copy_point = copy
    while source_point is not None:
        source_point.next = copy_point.next
        source_point = copy_point.next
        if source_point is not None:
            copy_point.next = source_point.next
            copy_point = source_point.next
        else:
            break
def main(head):
    if head is None:
        return None
    cp_node = Node(head.val, next=head.next)

    head.next = cp_node
    copy_node(cp_node)
    find_random(head, cp_node)
    split(head, cp_node)
    return cp_node