import csv
# from datetime import datetime

readed_data = []
matlabized_data = []

# precita subor a ulozi do premennej readed_data 
with open("data_cut.csv", "r") as file:
    data = csv.reader(file)

    for i in data:
        readed_data.append(i)

readed_data.pop(0)  # odstrani prvy element - nadpis "Datum, Cena"

# upravi data na spravny format ([index, konkretna_hodnota])
for i in range(len(readed_data)):
    matlabized_data.append([i+1, float(readed_data[i][1])])

with open("matlabized_data2.csv", "w") as file:
    writer = csv.writer(file)
    writer.writerows(matlabized_data)

