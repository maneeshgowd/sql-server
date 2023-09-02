-- 1.

/*
    DISTINCT - select distinct values in one or more columns of a table.
*/

-- Returns column_name1 and column_name2 with unique values
SELECT DISTINCT column_name1, column_name2 FROM table_name;

-- 2.

/*
    WHERE – filter rows in the output of a query based on one or more conditions.
*/

SELECT column_name FROM table_name WHERE column_name = 'some_value';

/*
NULL and three-valued logic

    In the database world, NULL is used to indicate the absence of any data value. 
    For example, when recording the customer information, the email may be unknown, so you record it as NULL in the database.

    Typically, the result of a logical expression is TRUE or FALSE. However, when NULL is involved in the logical evaluation, the result is UNKNOWN.
    Therefore, a logical expression may return one of three-valued logic: TRUE, FALSE, and UNKNOWN.
*/

-- Empty result, SQL dosen't evaluate UNKNOWN logic
SELECT column_name FROM table_name WHERE column_name = NULL;

-- USE IS NULL | IS NOT NULL to filter null values
SELECT column_name FROM table_name WHERE column_name IS NULL OR column_name IS NOT NULL;

-- 3.

/*
    AND – combine two Boolean expressions and return true if all expressions are true.
*/

SELECT column_price FROM table_name WHERE column_price > 10 AND column_price < 50;

-- 4.

/*
    OR–  combine two Boolean expressions and return true if either of conditions is true.
*/

SELECT column_price FROM table_name WHERE column_price > 10 OR column_price < 50;

-- 5.

/*
    IN – check whether a value matches any value in a list or a subquery.
*/

SELECT column_price FROM table_name WHERE column_price IN(10,20,30);
SELECT column_price FROM table_name WHERE column_price IN(10,20,30);

-- First evaluates Subquery and from that main query
SELECT column_price FROM table_name WHERE column_price IN(SELECT column_name FROM table_name WHERE column_id = 1);

-- 6.

/*
    BETWEEN – test if a value is between a range of values.
*/

SELECT column_price FROM table_name WHERE column_price BETWEEN 100 AND 500;
SELECT column_price FROM table_name WHERE column_price NOT BETWEEN 100 AND 500;

-- 7.

/*
    LIKE  –  check if a character string matches a specified pattern.

    - The percent wildcard (%): any string of zero or more characters.
    - The underscore (_) wildcard: any single character.
    - The [list of characters] wildcard: any single character within the specified set.
    - The [character-character]: any single character within the specified range.
    - The [^]: any single character not within a list or a range.
    - THE ! : Escape character to escape
*/

SELECT column_price FROM table_name WHERE column_price LIKE '%a%'
-- treats '%' literal string
SELECT column_price FROM table_name WHERE column_price LIKE '%30!%%' ESCAPE '!';

-- 8.

/*
    Column & table aliases – show you how to use column aliases to change the heading of the query output and table alias to improve the readability of a query.
*/

SELECT very_big_column_name AS cn FROM table_name;
SELECT very_big_column_name cn FROM table_name;
SELECT very_big_column_name 'cn' FROM table_name;
