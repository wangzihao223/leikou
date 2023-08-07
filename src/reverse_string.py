

def reverse_string(s):
    i = 0
    j = len(s) - 1

    while j > i:
        s[i], s[j] = s[j], s[i]
        j -= 1
        i += 1


if __name__ == '__main__':
    l = ["h","e","l","l","o"]
    reverse_string(l)
    print(l)