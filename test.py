from db import get_connection

def main():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SHOW TABLES;")
    tables = cur.fetchall()
    print("Tables in your database:")
    for t in tables:
        print(" -", t[0])
    cur.close()
    conn.close()

if __name__ == "__main__":
    main()