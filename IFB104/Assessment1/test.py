
numbers1=range(0,20,1)
numbers2=range(0,10,1)
last = -1
which = 0

while which < len(numbers1):
    if numbers1[which] < numbers2[which]:
        last = which
    which = which + 1
