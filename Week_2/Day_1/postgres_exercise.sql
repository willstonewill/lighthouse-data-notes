/* SQL Exercise
====================================================================
We will be working with database northwind.db we have set up and connected to in the activity Connect to Remote 
PostgreSQL Database earlier.


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
-- Q1. Write a query to get Product name and quantity/unit.
*/

SELECT productname, quantityperunit FROM products;

/* TASK II
Q2. Write a query to get most expense and least expensive Product list (name and unit price)
*/

SELECT productname, unitprice AS highest_lowest_price FROM products WHERE unitprice = (
    SELECT MAX(unitprice) FROM products)
UNION
SELECT productname, unitprice FROM products WHERE unitprice = (
    SELECT MIN(unitprice) FROM products);

/* TASK III
Q3. Write a query to count current and discontinued products.
*/

SELECT COUNT(*) FROM products WHERE unitsinstock > 0 AND discontinued = 1;

/* TASK IV
Q4. Select all product names and their category names (77 rows)
*/

SELECT products.productname AS product_name, categories.categoryname AS category_name
FROM products JOIN categories ON products.categoryid = categories.categoryid;

/* TASK V
Q5. Select all product names, unit price and the supplier region that don't have suppliers from USA region. (26 rows)
*/

SELECT DISTINCT country, region FROM suppliers;

SELECT products.productname AS product_name, products.unitprice AS unit_price, suppliers.region AS supplier_region
FROM products INNER JOIN suppliers ON products.supplierid = suppliers.supplierid
WHERE suppliers.country <> 'USA';

/* TASK VI
Q6. Get the total quantity of orders sold.( 51317)
*/

SELECT SUM(order_details.quantity) FROM orders JOIN order_details ON orders.orderid = order_details.orderid;

/* TASK VII
Q7. Get the total quantity of orders sold for each order.(830 rows)
*/

SELECT COUNT(*) FROM orders;

/* TASK VIII
Q8. Get the number of employees who have been working more than 5 year in the company. (9 rows)
*/

SELECT COUNT(*) FROM employees WHERE date_part('year', age(hiredate)) > 5;
