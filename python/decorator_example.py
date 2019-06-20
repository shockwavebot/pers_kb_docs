def my_decorator(function):
    def wrapper(*a):
        print('Function name: \t {}'.format(function.__name__))
        print('Arguments: \t {}'.format(a))
        print('Funcion result:  {}'.format(function(*a)))
    return wrapper

@my_decorator
def add(a,b):
    return a + b

if __name__ == '__main__':
    add(2,3)

    
Function name:   add
Arguments:       (1, 2)
Funcion result:  3
