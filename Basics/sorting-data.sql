/*
    * SELECT statement dosen't return data in a proper order.
    * Inorder to get data in a proper order we use ORDER BY clause
*/

SELECT
    column_name
FROM
    table_name
ORDER BY 
    column_name asc;
    --column_name | expression [ASC | DESC ];


-- e.g.

SELECT column_name1, column_name2 FROM table_name ORDER BY column_name1 desc, LEN(column_name2) asc;


