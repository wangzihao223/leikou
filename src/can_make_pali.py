def main(s, queries):
        n = len(s)
        ss = [[0] * 26 for _ in range(n + 1)]
        for i, c in enumerate(s, 1):
            ss[i] = ss[i - 1][:]
            ss[i][ord(c) - ord("a")] += 1
        ans = []
        for l, r, k in queries:
            cnt = sum((ss[r + 1][j] - ss[l][j]) & 1 for j in range(26))
            ans.append(cnt // 2 <= k)
        return ans

s = "abcda"
queries = [[3,3,0],[1,2,0],[0,3,1],[0,3,2],[0,4,1]]
main(s, queries)