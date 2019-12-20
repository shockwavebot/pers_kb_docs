# Creating custom Library 

Scope: `ROBOT_LIBRARY_SCOPE` : `TEST CASE` | `TEST SUITE` | `GLOBAL`

### Using builtin robot variables in custom robot libraries 

```
from robot.libraries.BuiltIn import BuiltIn

BuiltIn().get_variable_value("${SUITE NAME}")
BuiltIn().get_variable_value("${TEST NAME}")
BuiltIn().get_variable_value("${SUITE SOURCE}")
```


