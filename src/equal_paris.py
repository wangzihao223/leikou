from collections import Counter
def equal_pairs(grid):
    r = len(grid)
    num = 0
    for i in range(r):
        for j in range(r):
            count = 0

            for k in range(r):
                base = grid[i][k]
                if base == grid[k][j]:
                    count += 1
                else:
                    break
                    
            if count == r:
                num += 1
    return num

def hash(grid):
        res, n = 0, len(grid)
        cnt = Counter(tuple(row) for row in grid)
        print(cnt)
        res = 0
        for j in range(n):
            t = tuple([grid[i][j] for i in range(n)])
            print(t)
            res += cnt[t]
        return res

    # l = {}
    # for line in grid:
    #     str1 = ''.join([str(i) for i in line])

# grid = [[3,2,1],[1,7,6],[2,7,7]]
grid = [[3,1,2,2],[1,4,4,5],[2,4,2,2],[2,4,2,2]]
# print(equal_pairs(grid))
print(hash(grid))
                    