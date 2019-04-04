import unittest
from tests import TestMyTestingClass
from multiprocessing import Pool

def run_test(test_to_run):
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(test_to_run)

tests = [TestMyTestingClass('test_TC001'),
         TestMyTestingClass('test_TC002'),
         TestMyTestingClass('test_TC004'),
         TestMyTestingClass('test_TC003'), 
         TestMyTestingClass('test_TC005')]

if __name__ == '__main__':
    with Pool(5) as p:
        p.map(run_test, tests)
