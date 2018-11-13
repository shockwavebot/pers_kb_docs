import unittest
class Monolithic(unittest.TestCase):
    def step1(self):
        print('step1')
    def step2(self):
        print('step2')
    def step3(self):
        print('step3')
    def _steps(self):
        for attr in sorted(dir(self)):
            if not attr.startswith('step'):
                continue
            yield attr
    def test_foo(self):
        for _s in self._steps():
            try:
                getattr(self, _s)()
            except Exception as e:
                self.fail('{} failed({})'.format(attr, e))

if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(Monolithic)
    unittest.TextTestRunner().run(suite)
