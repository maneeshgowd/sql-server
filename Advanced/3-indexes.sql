 -- INDEXES IN SQL-SERVER (using Balanced-tree structure)

 /*
    1. CLUSTERED INDEX
    A clustered index stores data in a storted order in the form of data pages at the leaf nodes.
    - clustered index contains the table data itslef, so each table has only one clustered index,
         but can have 1 clustered index on multiple columns (composite index).
    - A clustered index is created automatically for a table with PK. If the table already has a clustered index
        and we create a PK later sql server will enforce PK has non-clustered index.

 */


    CREATE CLUSTERED INDEX index_name
    ON schema_name.table_name (column_list);  


 /*
    2. NON-CLUSTERED INDEX

    A non clustered index is a data structure that improves the speed of data retrieval from tables.
    - Sorts and stores data separately from the data rows in the table.
    - It contains a key(sorted data column), which is split in to pages and each key having a pointer to the data row in a table.
    - There can be more than 1 clustered index in a table.
 */

    CREATE NONCLUSTERED INDEX index_name
    ON table_name(column_list);

--When you create a nonclustered index that consists of multiple columns, the order of the columns in the index is very important.
--You should place the columns that you often use to query data at the beginning of the column list.    

CREATE INDEX ix_customers_name 
ON sales.customers(last_name, first_name);
---------------------

-- For example, the following statement finds customers whose last name is Albert.
-- Because the last_name is the leftmost column in the index, the query optimizer can leverage the index and uses the index seek method for searching:
SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Albert';

-- This statement finds customers whose first name is Adam. It also leverages the ix_customer_name index.
-- But it needs to scan the whole index for searching, which is slower than index seek.

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    first_name = 'Adam';

--NONCLUSTERED keyword is optional.


  /*
    3. UNIQUE INDEX

    A unique index ensures the index key columns do not contain any duplicate values.

    -- A unique index can be clustured or non-clustured.
    -- Throws error when duplicate value is inserted, even for NULL.
 */

    CREATE UNIQUE INDEX index_name
    ON table_name(column_list);

/*
    4. RENAME INDEX
*/

EXEC sp_rename 
    @objname = N'index_name', 
    @newname = N'new_index_name',   
    @objtype = N'INDEX';


/*
    5. DISABLE INDEX
 */

ALTER INDEX index_name ON table_name DISABLE;

-- DISABLE ALL on a table

-- NOTE; won't allow to query data until rebuild
ALTER INDEX ALL ON table_name DISABLE;

/*
    6. REBUILD INDEX
*/

-- 1
ALTER INDEX index_name 
ON table_name  
REBUILD;
-- 2
CREATE INDEX index_name 
ON table_name(column_list)
WITH(DROP_EXISTING=ON)

-- ENABLE ALL on a table
ALTER INDEX ALL ON table_name
REBUILD;

-- 3
DBCC DBREINDEX (table_name, index_name);

/*
    7. DROP INDEX
*/

-- The DROP INDEX statement does not remove indexes created by PRIMARY KEY or UNIQUE constraints.
--To drop indexes associated with these constraints, you use the ALTER TABLE DROP CONSTRAINT statement.

DROP INDEX IF EXISTS
    index_name1 ON table_name1,
    index_name2 ON table_name2;



---------------------------------------
-- DOWNSIDE OF INDEXES
-- space intesive
-- needs to updated when table data change (index fragmentation)