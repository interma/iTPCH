# iTPCH
interma's tpch test for greenplum

It used for a personal test env with small Scale Factor (e.g. 100).

Guides:
```
cd dbgen

# 01 compile dbgen
make

# 02 generate raw data (1GB)
./dbgen -vf -s 1
# and remove ending |
sed -i -e "s/|$//g" *.tbl

# 03 import data via copy command
psql tpch -c "\\COPY nation FROM 'nation.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY part FROM 'part.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY customer FROM 'customer.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY orders FROM 'orders.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY partsupp FROM 'partsupp.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY region FROM 'region.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY supplier FROM 'supplier.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY lineitem FROM 'lineitem.tbl' WITH DELIMITER '|';"

cd ..
# 04 run 22 queries
psql tpch -f query.sql > result.txt
# then check result
grep Time results.txt
```
