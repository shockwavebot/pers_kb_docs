def my_decorator(function):
    def wrapper(*a, **kw):
        print('Function name: \t {}'.format(function.__name__))
        print('Arguments: \t {}'.format(a))
        function.__globals__['injected_arg'] = 'Injected msg from wrapper...'
        return function(*a, **kw)
    return wrapper

@my_decorator
def add(a,b):
    print(injected_arg)
    return a + b

Result: 
>>> add(2,3)
Function name:   add
Arguments:       (2, 3)
Injected msg from wrapper...
5
>>> 
