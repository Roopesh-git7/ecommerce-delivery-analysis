create database E_Commerce_Shipping;

use E_Commerce_Shipping;
show tables;

select * from orders_table;
select * from delivery_table;

#Find total orders and delayed orders by warehouse
SELECT
  Warehouse_block,
  COUNT(*) AS total_orders,
  SUM(CASE WHEN `Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END) AS delayed_orders
FROM delivery_table
GROUP BY Warehouse_block;

#Calculate delay percentage by warehouse
SELECT
  Warehouse_block,
  ROUND(
    SUM(CASE WHEN `Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END) * 100.0
    / COUNT(*),
    2
  ) AS delay_pct
FROM delivery_table
GROUP BY Warehouse_block;

#Warehouse with highest delays (ORDER BY)
SELECT
  Warehouse_block,
  COUNT(*) AS delayed_orders
FROM delivery_table
WHERE `Reached.on.Time_Y.N` = 0
GROUP BY Warehouse_block
ORDER BY delayed_orders DESC;

#Warehouses with delay rate > 30% (HAVING)
SELECT
  Warehouse_block
FROM delivery_table
GROUP BY Warehouse_block
HAVING
  SUM(CASE WHEN `Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END) * 1.0
  / COUNT(*) > 0.30;
  
#Average product cost for delayed vs on-time orders
SELECT
  CASE 
    WHEN d.`Reached.on.Time_Y.N` = 1 THEN 'On-Time'
    ELSE 'Delayed'
  END AS status,
  AVG(o.Cost_of_the_Product) AS avg_cost
FROM orders_table o
JOIN delivery_table d ON o.ID = d.ID
GROUP BY status;

#Shipment mode delay comparison
SELECT
  Mode_of_Shipment,
  AVG(CASE WHEN `Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END) * 100 AS delay_pct
FROM delivery_table
GROUP BY Mode_of_Shipment;

#Subquery: warehouses above average delay
SELECT *
FROM (
  SELECT
    Warehouse_block,
    AVG(CASE WHEN `Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END) AS delay_rate
  FROM delivery_table
  GROUP BY Warehouse_block
) t
WHERE delay_rate >
  (SELECT AVG(CASE WHEN `Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END)
   FROM delivery_table);

#Explanation- Inner query calculates warehouse delay, Outer query compares with overall average.
CTE for cleaner delay logic
WITH delay_data AS (
  SELECT
    Warehouse_block,
    CASE WHEN `Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END AS delay_flag
  FROM delivery_table
)
SELECT
  Warehouse_block,
  AVG(delay_flag) * 100 AS delay_pct
FROM delay_data
GROUP BY Warehouse_block;

#Rank warehouses by delay (WINDOW FUNCTION)
SELECT
  Warehouse_block,
  delay_pct,
  RANK() OVER (ORDER BY delay_pct DESC) AS delay_rank
FROM (
  SELECT
    Warehouse_block,
    AVG(CASE WHEN `Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END) * 100 AS delay_pct
  FROM delivery_table
  GROUP BY Warehouse_block
) t;

#LAG: compare warehouse delay with previous warehouse
SELECT
  Warehouse_block,
  delay_pct,
  delay_pct - LAG(delay_pct) OVER (ORDER BY delay_pct) AS diff_from_prev
FROM (
  SELECT
    Warehouse_block,
    AVG(CASE WHEN `Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END) * 100 AS delay_pct
  FROM delivery_table
  GROUP BY Warehouse_block
) t;

#LEAD: next warehouse delay comparison
SELECT
    Warehouse_block,
    delay_pct,
    delay_pct - LEAD(delay_pct) OVER (ORDER BY delay_pct) AS diff_with_next
FROM (
    SELECT
        Warehouse_block,
        AVG(CASE 
                WHEN `Reached.on.Time_Y.N` = 0 THEN 1 
                ELSE 0 
            END) * 100 AS delay_pct
    FROM delivery_table
    GROUP BY Warehouse_block
) t;

#Customer care calls vs delay (advanced AVG logic)
SELECT
  Customer_care_calls,
  AVG(CASE WHEN `Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END) * 100 AS delay_pct
FROM orders_table o
JOIN delivery_table d ON o.ID = d.ID
GROUP BY Customer_care_calls;

#Top 5 worst orders by weight & delay
SELECT *
FROM delivery_table
WHERE `Reached.on.Time_Y.N` = 0
ORDER BY Weight_in_gms DESC
LIMIT 5;

#Percentage of delayed orders overall
SELECT
  AVG(CASE WHEN `Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END) * 100 AS overall_delay_pct
FROM delivery_table;

#JOIN + CASE for combined analysis
SELECT
  o.Product_importance,
  AVG(CASE WHEN d.`Reached.on.Time_Y.N` = 0 THEN 1 ELSE 0 END) * 100 AS delay_pct
FROM orders_table o
JOIN delivery_table d ON o.ID = d.ID
GROUP BY o.Product_importance;