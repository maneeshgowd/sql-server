-- 1.

/*  
    The OFFSET and FETCH clauses are the options of the ORDER BY clause.
    They allow you to limit the number of rows to be returned by a query.

e.g. syntax

ORDER BY column_list [ASC |DESC]
OFFSET offset_row_count {ROW | ROWS}
FETCH {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY

*/

/*
    - OFFSET clause specifies the number of rows to skip before return rows from query.
    - FETCH clause specfies the number of rows to return after the OFFSET clause has been processed.
    - The OFFSET clause is mandatory while the FETCH is optional. FIRST, NEXT are synonyms
*/

-- Note that you must use the OFFSET and FETCH clauses with the ORDER BY clause. Otherwise, you will get an error.

SELECT column_name FROM table_name ORDER BY column_name 
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

SELECT column_name FROM table_name ORDER BY column_name 
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY;

-- 2.

/*
    The SELECT TOP clause allows you to limit the number of rows or percentage of rows returned in a query result set.

e.g.
    SELECT TOP (expression) [PERCENT]
    [WITH TIES]
    FROM 
        table_name
    ORDER BY 
        column_name;
*/

-- SELECTS TOP 10 data out of result set
SELECT TOP (10) * FROM table_name;

-- SELECTS top 1 percent data of the entrire result set
SELECT TOP 1 PERCENT column_name FROM table_name;

-- SELECTS top 3 data with highest price along with duplicate highest values in top 3
SELECT TOP 3 WITH TIEST column_price FROM table_name ORDER BY column_price DESC;