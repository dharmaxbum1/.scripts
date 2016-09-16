#! /usr/bin/env python

from random import randint


def random_name_generator(first, second, x):
	
    names = []
    for i in range(0, int(x)):
        random_first = randint(0, len(first)-1)
        random_last = randint(0, len(second)-1)
        names.append("{0} {1}".format(
            first[random_first],
            second[random_last])
        )
    return set(names)


first_names = [
"Sotiris", "Stamatis", "Spyros", "Savvas", "Kwstas", \
"Thomas", "Takis", "Petros", "Xaris", "Giwrgos", "Nikos", "Kosmas", \
"Tasos", "Michalis", "Vasilis", "Giannis", "Vaggelis", "Dimitris", \
"Alexis", "Panagiotis", "Xristos", "Manolis"
]

last_names = [
"Roussis", "Petropoulos", "Resvanis", "Chaldaios", \
"Anastasiou", "Vervitis", "Boufis", "Liagkas", "Euthimiou", \
"Petrakis", "Kiourktsis", "Koukoulomatis", "Panaousis", "Biberias", \
"Mpistinas", "Zoutis", "Tsiklidis"
]

while True:
    try:
        number = int(input('Enter number of names you want to generate: '))
    except ValueError:
        continue
    else:
        break

names = random_name_generator(first_names, last_names, number)
print('\n'.join(names))
