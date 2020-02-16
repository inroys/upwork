import csv

with open('20200213-ProductIdPerKeyword.csv') as csv_file:
    next(csv_file)
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    result = dict()
    for row in csv_reader:
        if row[0] in result:
            result[row[0]].append(row[1])
            line_count += 1
        else:
            result[row[0]] = [row[1]]
            line_count += 1
    print(f'Processed {line_count} lines.')
    print(f'Found {len(result)} items')

with open('overlap1.csv', 'w', newline='') as overlap:
    wr = csv.writer(overlap, quoting=csv.QUOTE_ALL)
    wr.writerow(["SK","SKNbrProducts","CK","CKNbrProducts","NbrSKProductsInCK"])
    for key1 in result:
        for key2 in result:
            if key1 != key2:
                wr.writerow([key1,len(result[key1]),key2,len(result[key2]),len(list(set(result[key1]) & set(result[key2])))])
