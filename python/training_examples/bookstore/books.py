import sqlite3


class Books:


    def __init__(self, db="books.db"):
        try:
            self.conn = sqlite3.connect(db)
            print(f"INFO: Connected to db: {db}")
        except:
            print(f"ERR: Bad connection to: {db}")
        self.curs = self.conn.cursor()
        self.curs.execute("CREATE TABLE IF NOT EXISTS book (id INTEGER PRIMARY KEY, title text, author text, year integer, isbn integer)")


    def insert(self, title, author, year, isbn):
        self.curs.execute("INSERT INTO book VALUES (NULL,?,?,?,?)",(title, author, year, isbn))
        self.conn.commit()


    def view_entire_db(self):
        self.curs.execute("SELECT * FROM book")
        return self.curs.fetchall()


    def search(self, title, author, year, isbn):
        self.curs.execute("SELECT * FROM book WHERE title=? OR author=? OR year=? OR isbn=?", (title, author, year, isbn))
        return self.curs.fetchall()


    def update(self, id, title, author, year, isbn):
        self.curs.execute("UPDATE book SET title=?, author=?, year=?, isbn=? WHERE id=?",(title,author,year,isbn,id))
        self.conn.commit()


    def delete(self, id):
        self.curs.execute("DELETE FROM book WHERE id=?",(id,))
        self.conn.commit()


    def __del__(self):
        self.conn.close()
        print(f"INFO: Connection to db closed.")


