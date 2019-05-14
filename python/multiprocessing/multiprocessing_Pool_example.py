from time import sleep
from datetime import datetime
from multiprocessing import Pool
import os

def testrun(delay=1):
    pid = os.getpid()
    timestamp_before = datetime.now().strftime('%H:%M:%S,%f')
    print(f'PID: {pid} timestamp before delay: {timestamp_before} Arg: {delay}')
    sleep(delay)
    timestamp_after = datetime.now().strftime('%H:%M:%S,%f')
    print(f'PID: {pid} timestamp after delay: {timestamp_after} Arg: {delay}')
    return pid 

with Pool(3) as p:
    p.map(testrun, [1,2,3,2.5,1.5])

# Result: 

# PID: 23497 timestamp before delay: 11:42:25,377110 Arg: 1
# PID: 23498 timestamp before delay: 11:42:25,377248 Arg: 2
# PID: 23499 timestamp before delay: 11:42:25,377376 Arg: 3
# PID: 23497 timestamp after delay:  11:42:26,378489 Arg: 1
# PID: 23497 timestamp before delay: 11:42:26,379104 Arg: 2.5
# PID: 23498 timestamp after delay:  11:42:27,379619 Arg: 2
# PID: 23498 timestamp before delay: 11:42:27,380300 Arg: 1.5
# PID: 23499 timestamp after delay:  11:42:28,380706 Arg: 3
# PID: 23497 timestamp after delay:  11:42:28,881821 Arg: 2.5
# PID: 23498 timestamp after delay:  11:42:28,882026 Arg: 1.5
# [23497, 23498, 23499, 23497, 23498]


# modification for using multiple arguments - starmap

def testrun(name, delay):
    pid = os.getpid()
    timestamp_before = datetime.now().strftime('%H:%M:%S,%f')
    print(f'PID: {pid} timestamp before delay: {timestamp_before} Name: {name}')
    sleep(delay)
    timestamp_after = datetime.now().strftime('%H:%M:%S,%f')
    print(f'PID: {pid} timestamp after  delay: {timestamp_after} Name: {name}')
    return pid 

with Pool(3) as p:
    p.starmap(testrun, [('f1',1),('f2',2),('f3',3),('f4',2.5),('f5',1.5)])
    
    
# Result: 

# PID: 27332 timestamp before delay: 12:04:41,956811 Name: f2
# PID: 27331 timestamp before delay: 12:04:41,956755 Name: f1
# PID: 27333 timestamp before delay: 12:04:41,956940 Name: f3
# PID: 27331 timestamp after  delay: 12:04:42,958513 Name: f1
# PID: 27331 timestamp before delay: 12:04:42,959149 Name: f4
# PID: 27332 timestamp after  delay: 12:04:43,959553 Name: f2
# PID: 27332 timestamp before delay: 12:04:43,960136 Name: f5
# PID: 27333 timestamp after  delay: 12:04:44,960596 Name: f3
# PID: 27332 timestamp after  delay: 12:04:45,461792 Name: f5
# PID: 27331 timestamp after  delay: 12:04:45,461792 Name: f4
# [27331, 27332, 27333, 27331, 27332]
