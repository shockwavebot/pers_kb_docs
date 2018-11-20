# remote python debugger

# install
pip install rpdb

import rpdb
debugger = rpdb.Rpdb(port=12345)
debugger.set_trace()

# to access the debugger
telnet host port

s(tep) - Execute the current line, stop at the first possible occasion (either in a function that is called or on the next line in the current function).
n(ext) - Continue execution until the next line in the current function is reached or it returns. (The difference between next and step is that step stops inside a called function, while next executes called functions at (nearly) full speed, only stopping at the next line in the current function.)
r(eturn) - Continue execution until the current function returns.
c(ont(inue)) - Continue execution, only stop when a breakpoint is encountered.
q(uit) - Quit from the debugger. The program being executed is aborted.

###
dir() -- list of scope vars
