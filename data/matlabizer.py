import csv
from datetime import datetime

matlabized_data = []

# vrati kolko dni ubehlo od 1.1.
def days_since_1_jan(date_str: str) -> int:
    date_format = "%d-%m"
    date = datetime.strptime(date_str, date_format).replace(year=2024)
    jan_1 = datetime(date.year, 1, 1)

    return (date - jan_1).days


with open("data_cut.csv", "r", newline="") as file:
    data = csv.reader(file, delimiter=",")

    # prepise subor csv do listu
    mylist = []
    for i in data:
        mylist.append(i)

    # naplni list matlabized_data
    for i in mylist[1:]:
        t = days_since_1_jan(i[0])
        f = float(i[1])
        matlabized_data.append([t, f])

print(matlabized_data)
    
with open("matlabized_data.csv", "w", newline="") as file:
    writer = csv.writer(file)

    for i in matlabized_data:
        writer.writerow(i)
