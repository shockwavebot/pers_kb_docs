# Creating custom Library 

Scope: `ROBOT_LIBRARY_SCOPE` : `TEST CASE` | `TEST SUITE` | `GLOBAL`

### Using builtin robot variables in custom robot libraries 

```
from robot.libraries.BuiltIn import BuiltIn

BuiltIn().get_variable_value("${SUITE NAME}")
BuiltIn().get_variable_value("${TEST NAME}")
BuiltIn().get_variable_value("${SUITE SOURCE}")
```

Window Size:
```
drv = BuiltIn().get_library_instance("SeleniumLibrary").driver
screen_size = drv.get_window_size()
drv.set_window_size(width, height)
```
