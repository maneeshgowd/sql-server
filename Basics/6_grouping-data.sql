-- GROUPING DATA

/*
    1. GROUP BY - clause

    The Group by clause allows to arrange the rows of a query in groups.
    - The Group by clause are often used with aggregate functions..SUM(), avg()..

*/

SELECT
    city,
    COUNT (customer_id) customer_count
FROM
    sales.customers
GROUP BY
    city
ORDER BY
    city;

/*
    In this example, the GROUP BY clause groups the customers together by city and
    the COUNT() function returns the number of customers in each city.
*/

/*
    2. HAVING - clause

    Having clause is often used with the GROUP BY clause to filter groups based on a specified list of conditions.

    - Having clause filters groups, like where clause filters select query result set.
    - Only true condtitions are evaluated in having clause.
*/

SELECT
    column_name1,
    column_name2,
    aggregate_function (column_name3) alias
FROM
    table_name
GROUP BY
    column_name1,
    column_name2
HAVING
    aggregate_function (column_name3) > value;

-- Aggregate in select should be specifies in HAVING because HAVING clause is processed after group by.

/*
    3. GROUPING SETS - sub-clause of GROUP BY

    The GROUPING SETS defines multiple grouping sets in the same query.

    - A grouping set is a group of columns by which you group. 
    - Typically, a single query with an aggregate defines a single grouping set.
*/

-- The following query returns the sales amount by brand. It defines a grouping set (brand):
SELECT
    brand,
    SUM (sales) sales
FROM
    sales.sales_summary
GROUP BY
    brand
ORDER BY
    brand;

--GROUPING SET syntax:
SELECT
    column1,
    column2,
    aggregate_function (column3)
FROM
    table_name
GROUP BY
    GROUPING SETS (
        (column1, column2),
        (column1),
        (column2),
        ()
);

/*
For eg: In a multi chain restuarant business table,
    You can group query into total sales in all restuarant,
    Highest items sales in all resturant,
    Lowest items sales,
    No. of items sold by category etc.. using grouping set in a single table.
*/

/*
    4. CUBE - sub-clause of GROUP BY

    The CUBE generates all possible grouping sets based on the dimension columns.
*/

SELECT
    d1,
    d2,
    d3,
    aggregate_function (c4)
FROM
    table_name
GROUP BY
    CUBE (d1, d2, d3);   

-- Above query using grouping sets

SELECT
    d1,
    d2,
    d3,
    aggregate_function (c4)
FROM
    table_name
GROUP BY
    GROUPING SETS (
        (d1,d2,d3), 
        (d1,d2),
        (d1,d3),
        (d2,d3),
        (d1),
        (d2),
        (d3), 
        ()
     );

--If you have N dimension columns specified in the CUBE, you will have 2N grouping sets.

/*
    5. ROLLUP - sub-clause of GROUP BY

    The SQL Server ROLLUP is a subclause of the GROUP BY clause which provides a shorthand for defining multiple grouping sets.
    -Unlike the CUBE subclause, ROLLUP does not create all possible grouping sets based on the dimension columns; the CUBE makes a subset of those.

    When generating the grouping sets, ROLLUP assumes a hierarchy among the dimension columns and only generates grouping sets based on this hierarchy.

    The ROLLUP is often used to generate subtotals and totals for reporting purposes.
*/

SELECT
    d1,
    d2,
    d3,
    aggregate_function(c4)
FROM
    table_name
GROUP BY
    ROLLUP (d1, d2, d3);

-- And the ROLLUP(d1,d2,d3) creates only four grouping sets, assuming the hierarchy d1 > d2 > d3, as follows:

-- (d1, d2, d3)
-- (d1, d2)
-- (d1)
-- ()


-- NOTE: Partial grouping can also be done by not specifying it in Grouping sets, cube or rollup

SELECT
    d1,
    d2,
    d3,
    aggregate_function(c4)
FROM
    table_name
GROUP BY
    d1, 
    ROLLUP (d2, d3); -- CUBE(d2,d3)