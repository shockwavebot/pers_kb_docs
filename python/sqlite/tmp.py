# Write a query: return 2 columns: city and number of donors that can connect to acceptors 
# Condition is: same BG and same city and donor has at least if not more then needed by acceptor 

import sqlite3
conn = sqlite3.connect('BLOOD_DONORS.db')
c = conn.cursor()
c.execute('''CREATE TABLE IF NOT EXISTS donor (name text, gender text, city text, bg text, amount int);''')
c.execute('''CREATE TABLE IF NOT EXISTS acceptor (name text, gender text, city text, bg text, amount int);''')
c.execute('''INSERT INTO donor VALUES ('MARKO','M','JAGODINA','AB+', 7);''')
c.execute('''INSERT INTO donor VALUES ('JELENA','F','BEOGRAD','AB+', 3);''')
c.execute('''INSERT INTO donor VALUES ('MARIJA','F','BEOGRAD','A-', 6);''')
c.execute('''INSERT INTO donor VALUES ('BORKO','M','BEOGRAD','AB+', 9);''')
c.execute('''INSERT INTO donor VALUES ('VLADA','M','JAGODINA','A+', 1);''')
c.execute('''INSERT INTO acceptor VALUES ('PETAR','M','JAGODINA','A+', 9);''')
c.execute('''INSERT INTO acceptor VALUES ('MIRKO','M','JAGODINA','AB+', 8);''')
c.execute('''INSERT INTO acceptor VALUES ('SONJA','F','BEOGRAD','AB+', 3);''')
c.execute('''INSERT INTO acceptor VALUES ('DANICA','F','BEOGRAD','A+', 1);''')
c.execute('''INSERT INTO acceptor VALUES ('VLADA','M','JAGODINA','A+', 5);''')
conn.commit()

c.execute('''TODO''')

conn.close()
