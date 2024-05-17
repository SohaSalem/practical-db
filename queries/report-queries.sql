/*Write an SQL query to generate a daily report of the total revenue for a specific date. */

SELECT SUM(total_amount) AS TotalAmount
FROM "order" WHERE
DATE(order_date)='2023-07-22';
  


/** Write an SQL query to generate a monthly report of the top-selling products in a given month.*/

SELECT TO_CHAR(o.order_date, 'YY-MM') AS Months,
       od.product_id AS ProductId,
       p.name AS ProductName,
       SUM(od.quantity) AS TotalQuantity
FROM public."order_details" od
JOIN public."order" o ON o.order_id = od.order_id
JOIN public."product" p ON p.product_id = od.product_id
WHERE TO_CHAR(o.order_date, 'YY-MM') = '23-10'
GROUP BY TO_CHAR(o.order_date, 'YY-MM'), od.product_id, p.name
ORDER BY TotalQuantity DESC;



/** Write a SQL query to retrieve a list of customers who have placed orders totaling more than $500 in the past month.
Include customer names and their total order amounts. */

SELECT c.customer_id, c.first_name, c.last_name, SUM(o.total_amount) AS total_order_amount
FROM "customer" c
JOIN "order" o ON c.customer_id = o.customer_id
WHERE o.order_date >= date_trunc('month', current_date) - INTERVAL '1 month'
  AND o.order_date < date_trunc('month', current_date)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > 500;


/** * Write a SQL query to search for all products with the word "camera" in either the product name or description. */
Select product_id, name, description from product
where name like '%camera%' or description like '%camera%';


/*
Can you design a query to suggest popular products in the same category for the same author,
excluding the Purchsed product from the recommendations?
this is an example of the product id :  de0528f0-3ed0-4849-a6fd-b7952e39e7d9
*/
SELECT p.name
FROM product AS p
INNER JOIN category AS c ON p.category_id = c.category_id
WHERE p.category_id = 
    (SELECT category_id FROM product WHERE product_id = 'de0528f0-3ed0-4849-a6fd-b7952e39e7d9')
  AND p.product_id <> 'de0528f0-3ed0-4849-a6fd-b7952e39e7d9' -- Exclude the viewed product
ORDER BY 
    (SELECT COUNT(*) FROM order_details AS od WHERE od.product_id = p.product_id) DESC
LIMIT 5;


/* I think about editing the product and add author for each column or a seller so the query will be  */
SELECT p.name
FROM product AS p
INNER JOIN category AS c ON p.category_id = c.category_id
WHERE p.category_id = 
    (SELECT category_id FROM product WHERE product_id = 'de0528f0-3ed0-4849-a6fd-b7952e39e7d9')
  AND p.author_id = 
    (SELECT author_id FROM product WHERE product_id = 'de0528f0-3ed0-4849-a6fd-b7952e39e7d9') -- Same author
  AND p.product_id <> 'de0528f0-3ed0-4849-a6fd-b7952e39e7d9' -- Exclude the viewed product
ORDER BY 
    (SELECT COUNT(*) FROM order_details AS od WHERE od.product_id = p.product_id) DESC
LIMIT 5;
