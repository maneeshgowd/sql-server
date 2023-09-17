-- SQL SERVER INNER JOIN

/*
    The INNER JOIN queries data from two or more tables based on matching condition.

    SYNTAX: 

    SELECT
    select_list
    FROM
        T1
    INNER JOIN T2 ON join_predicate;
*/

SELECT
    product_name,
    category_name,
    list_price
FROM
    production.products p
INNER JOIN production.categories c 
    ON c.category_id = p.category_id
ORDER BY
    product_name DESC;

/*
    For each row in the production.products table, the inner join clause matches it with every row in the product.categories
     table based on the values of the category_id column:

    - If both rows have the same value in the both tables the inner join includes them as a new row in the result set.

    - else inner join ignores them and doesn't include them in the result set.
*/

-- SQL SERVER LEFT JOIN

/*
    The LEFT JOIN returns all rows from the left table and the matching rows from the right table.
     If no matching rows are found in the right table, NULL are used.

    - If no rows matches in the second table it will be returned as null
*/

SELECT
    product_name,
    category_name,
    list_price
FROM
    production.products p
LEFT JOIN production.categories c 
    ON c.category_id = p.category_id AND p.categories IS NOT NULL
ORDER BY
    product_name DESC;

-- SQL SERVER RIGHT JOIN

/*
    The RIGHT JOIN returns all rows from the left table and the matching rows from the right table.
     If no matching rows are found in the right table, NULL are used.

    - If no rows matches in the first table it will be returned as null
*/

SELECT
    product_name,
    category_name,
    list_price
FROM
    production.products p
RIGHT JOIN production.categories c 
    ON c.category_id = p.category_id AND p.categories IS NOT NULL
ORDER BY
    product_name DESC;

-- SQL SERVER FULL JOIN

/*
    The FULL JOIN returns rows for both the tables left and right.

    - when no matching exists for left table, right table rows is null
    - when no matching exists for right table, left table rows is null

*/

SELECT
    product_name,
    category_name,
    list_price
FROM
    production.products p
FULL OUTER JOIN production.categories c 
    ON c.category_id = p.category_id AND p.categories IS NOT NULL
ORDER BY
    product_name DESC;

-- SQL SERVER CROSS JOIN

/*
    The CROSS JOIN joins every row from the first table with every row from the second table.
    - It returns a cartesian product of rows from both tables.

    - Unlike other joins cross joins dosen't establish a relationship with tables(no join_predicate)

*/

SELECT
    s.store_id,
    p.product_id
FROM
    sales.stores s
CROSS JOIN production.products p

-- SQL SERVER SELF JOIN

/*
    A self join allows you to join a table to itself. It helps query hierarchical data or compare rows within the same table.

    A self join uses the inner join or left join clause.
    - Because the query that uses the self join references the same table, the table alias is used to assign different names to the same table within the query.
*/

SELECT
    c1.city,
    c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id > c2.customer_id
AND c1.city = c2.city
ORDER BY
    city,
    customer_1,
    customer_2;