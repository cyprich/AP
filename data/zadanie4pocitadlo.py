name = "Peter Cyprich"
name2 = ""
count = 1

for i in name:
    if i != " ":
        name2 += str(count%10)
        count += 1
    else:
        name2 += " "

print(name)
print(name2)
