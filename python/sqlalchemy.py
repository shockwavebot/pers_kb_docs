# CONNECTION
from sqlalchemy import create_engine
# dialect+driver://username:password@host:port/database
engine = create_engine('postgresql://mstan:mstanpass@172.1.10.221:10901/mytestdb')
connection = engine.connect()

# TABLE 
from sqlalchemy import MetaData, Table 
metadata = MetaData() 
table = Table('table_name', metadata, autoload=True, autoload_with=engine)

# SELECT
from sqlalchemy import select
stmt = select([table.c.order_id, table.c.creation_time]).where(table.columns.order_id == '1001')
results = connection.execute(stmt).fetchall()

