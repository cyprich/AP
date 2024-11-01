# premeni data z csv priamo do podoby matlabovskeho vektoru aby sa dalo len copy and paste

import csv

readed_data = []
matlabized_data = []

# precita subor a ulozi do premennej readed_data 
with open("data_cut.csv", "r") as file:
    data = csv.reader(file)

    for i in data:
        readed_data.append(i)

readed_data.pop(0)  # odstrani prvy element - nadpis "Datum, Cena"
for i in readed_data:
    matlabized_data.append(float(i[1]))


with open("ultramatlabized_data", "w") as file:
    file.write("[")

    for i in matlabized_data:
        file.write(f"{i} ")

    file.write("]")

