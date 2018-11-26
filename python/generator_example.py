def simple_generator_function():
    print('Before 1')
    yield 1
    print('After 1, before 2')
    yield 2
    print('After 2, before 3')
    yield 3
    print('After 3') # this runs when calling 4th next()

def countdown(num):
    print('Starting')
    while num > 0:
        yield num
        num -= 1

if __name__ == '__main__':
    # Example 1: simple example and using next to iterate
    gen = simple_generator_function()
    print(next(gen))
    print(next(gen))
    print(next(gen))
    try:
        print(next(gen))
    except StopIteration:
        print('End of generator iterations.')
    # Example 2: countdown
    for i in countdown(4):
        print(i)
