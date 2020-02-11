
import os 

table_names = []
with open('../sql/db.sql') as fp:
    table_names = [line.split()[2] for line in fp if 'TABLE' in line]
print(table_names)
for name in table_names:
    print(f'DROP TABLE {name} cascade constraints;')