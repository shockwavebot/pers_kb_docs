from enum import Enum


class AllergiesExample(Enum):
    EGGS = 1
    PEANUTS = 2
    SHELLFISH = 4
    STRAWBERRIES = 8
    TOMATOES = 16
    CHOCOLATE = 32
    POLLEN = 64
    CATS = 128

if __name__ == '__main__':
    # iterate 
    for i in AllergiesExample:
        print('{} {}'.format(i.name, i.value))
