# The idea is to divide the array into two subsets - sorted subset and unsorted subset.
# Initally sorted subset consists of only one first element at index 0.
# Then for each iteration, insertion sort removes next element from the unsorted subset,
# finds the location it belongs within the sorted subset, and inserts it there.
# It repeats until no input elements remain.

# unsroted_array = [3,5,1,2]
# i1 : [(3),5,1,2]
# i2 : [(3,5),1,2]
# i3 : [(1,3,5),2]
# i4 : [(1,2,3,5)]

def insertion_sort(unsroted_array):
    sorted = [unsroted_array[0]]
    for i in range(1, len(unsroted_array)):
        j = len(sorted)
        while j>0 and unsroted_array[i] <= sorted[j-1]:
            j=j-1
        sorted.insert(j, unsroted_array[i])
    return sorted

import pytest

def test_size_one_array():
    assert insertion_sort([1]) == [1]

def test_size_two_array():
    assert insertion_sort([2,1]) == [1,2]

def test_all_equal_elements():
    assert insertion_sort([2,2,2,2]) == [2,2,2,2]

def test_size_20_array():
    expected = [-1,0,0,1,1,2,2,2,3,4,5,6,7,8,9,111,112,114,1005,10010]
    array = [10010,1,2,1005,-1,0,6,0,1,111,2,2,3,4,5,7,8,9,112,114]
    assert insertion_sort(array) == expected
