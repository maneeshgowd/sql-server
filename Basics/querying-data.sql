/*
 * Database tables are objects that store all the data in a database. In a table data is logically organized in a row-column format.
 * Each row represents a unique record in a table, and column represt a field.
 * SQL server uses schemas to logically group tables and other database objects.
*/

-- For querying data we use SELECT statement

-- To select specific columns only
SELECT column_name1, column_name2, ...n FROM table_name;

-- To select every column for table
SELECT * FROM table_name;

--However, you should not use the SELECT * for production code due to the following reasons:

/*
    1. First, SELECT * often retrieves more data than your application needs to function. 
       It causes unnecessary data to transfer from the SQL Server to the client application, taking more time for data to travel across the network and slowing down the application.
    2. Second, if the table is added one or more new columns, the SELECT * just retrieves all columns that include the newly added columns which were not intended for use in the application.
       This could make the application crash.
*/