""""
二分查找 id
"""


# before
# for i in range(count):
#     if alldata[i]["id"] < last_id:
#         data_lst = {
#             "id": alldata[i]["id"],
#             "bzh": alldata[i]["bzh"],
#             "bzid": alldata[i]["bzid"] or "",
#             "sfsl": alldata[i]["sfsl"]

def f1(all_data, last_id):
    if not all_data:
        return None
    if all_data[-1]["id"] >= last_id:
        return None
    # all_data is dsc
    length = len(all_data)
    left = 0
    right = length - 1
    while right >= left:
        k = (right + left) // 2
        print(right, left, k)
        if all_data[k]["id"] == last_id:
            return k + 1
        elif all_data[k]["id"] > last_id:
            left = k + 1
        else:
            right = k - 1

    if right < left:
        return left




def f(list_item, find_num):
    length = len(list_item)
    left = 0
    right = length - 1
    k = (right + left) // 2
    while right >= left:
        print(right, left, k)
        if list_item[k] == find_num:
            return k
        elif list_item[k] > find_num:
            right = k - 1
            k = (right + left) // 2
        else:
            left = k + 1
            k = (right + left) // 2
    if right < left:
        return left, right, k

def creat_list():
    data = []
    for i in range(10):
       data.append({"id": i})
    return data

if __name__ == '__main__':
    l = creat_list()
    l.reverse()
    print(l)
    r = f1(l, 8.9)
    print(r)