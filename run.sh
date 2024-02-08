#!/bin/bash
set -x
cd dbgen

# 01 compile dbgen
make

# 02 generate raw data
./dbgen -vf -s 1
# and remove ending |
sed -i -e "s/|$//g" *.tbl

# 03 create tables
psql tpch -f schema.sql

# 04 import data via copy command
psql tpch -c "\\COPY nation FROM 'nation.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY part FROM 'part.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY customer FROM 'customer.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY orders FROM 'orders.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY partsupp FROM 'partsupp.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY region FROM 'region.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY supplier FROM 'supplier.tbl' WITH DELIMITER '|';"
psql tpch -c "\\COPY lineitem FROM 'lineitem.tbl' WITH DELIMITER '|';"

cd ..
# 05 run all queries
psql tpch -f query.sql > result.txt

