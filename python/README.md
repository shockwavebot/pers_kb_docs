# Python notes

### Meta classes

- Class of a class
- Subtype of `type`
- Class factory: `MyClass = type('MyClass', (), {}) # returns a class object`

```python
def f(obj):
    print('attr = {}'.format(obj.attr))

Foo = type(
        'Foo',
        (),
        {
            'attr': 32,
            'print_attr': f
        }
)
```
