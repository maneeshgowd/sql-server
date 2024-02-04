/*
    VIEWS 

    SQL-SERVER VIEWS are named queries which are stored in database catalog for to be referred later.

    1. Views helps in (SECURITY).
        -> Users can be restricted to confidential tables and provided access to views for read-only query.
        -> Users can limit the number of information displayed in the result set.
    
    2. Views helps in (SIMPLICITY, COMPLEXITY).
        -> Allows complex quries to be stored in views which helps in simplicity.

*/


-- 1. CREATE VIEW

CREATE VIEW sales.staff_sales
(
    first_name,
    -- columns to display on result set
    last_name,
    year,
    amount
)
AS
    SELECT
        first_name,
        last_name,
        YEAR(order_date),
        SUM(list_price * quantity) amount
    FROM
        sales.order_items i
        INNER JOIN sales.orders o
        ON i.order_id = o.order_id
        INNER JOIN sales.staffs s
        ON s.staff_id = o.staff_id
    GROUP BY 
        first_name, 
        last_name, 
        YEAR(order_date);


-- 2. ALTER VIEW
CREATE OR ALTER VIEW sale.staff_sales
(
    first_name,
    last_name,
    year,
    amount,
    customer_name
)
AS
    SELECT
        first_name,
        last_name,
        YEAR(order_date),
        SUM(list_price * quantity) amount,
        concat(first_name, ' ', last_name) as customer_name
    FROM
        sales.order_items i
        INNER JOIN sales.orders o
        ON i.order_id = o.order_id
        INNER JOIN sales.staffs s
        ON s.staff_id = o.staff_id
    GROUP BY 
        first_name, 
        last_name, 
        YEAR(order_date);

-- 3. RENAME VIEW

EXEC sp_rename 
    @objname = 'schema_name.existing_name',
    @newname = 'new_name';


-- 4. DROP VIEW
DROP VIEW IF EXISTS schema_name.view_name;
-- OR to drop multiple views
DROP VIEW IF EXISTS 
    schema_name.view_name, 
    schema_name.view_name;

-- 5. GET LIST OF ALL THE SYSTEM VIEW INFORMATION

SELECT
    OBJECT_SCHEMA_NAME(v.object_id) schema_name,
    v.name
FROM
    sys.views as v;

-- OR

SELECT
    OBJECT_SCHEMA_NAME(o.object_id) schema_name,
    o.name
FROM
    sys.objects as o
WHERE
	o.type = 'V';

-- 6. GET INFO ABOUT A PARTICULAR VIEW

SELECT
    definition,
    uses_ansi_nulls,
    uses_quoted_identifier,
    is_schema_bound
FROM
    sys.sql_modules
WHERE
    object_id
    = object_id(
            'schema_name.view_name'
        );

-- OR

EXEC sp_helptext 'schema_name.view_name'
;

-- or

SELECT
    OBJECT_DEFINITION(
        OBJECT_ID(
            'schema_name.view_name'
        )
    ) view_info;