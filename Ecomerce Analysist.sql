CREATE TABLE customers_dataset(
        customer_id varchar(100),
        customer_unique_id varchar(100),
        customer_zip_code_prefix varchar(50),
        customer_city varchar(50),
        customer_state varchar(50),
        primary key(customer_id)
);


CREATE TABLE order_dataset (
        order_id VARCHAR(100),
        customer_id VARCHAR(100),
        order_status VARCHAR(50),
        order_purchase_timestamp timestamp,
        order_approved_at timestamp,
        order_delivered_carrier_date timestamp,
        order_delivered_customer_date timestamp,
        order_estimated_delivery_date timestamp,
          PRIMARY KEY (order_id),
        CONSTRAINT fk_customer
      FOREIGN KEY(customer_id) 
        REFERENCES customers_dataset(customer_id)
);


CREATE TABLE product_dataset(
        id serial,
        product_id varchar(100),
        product_category_name varchar(50),
        product_name_lenght real,
        product_description_lenght real,
        product_photos_qty real,
        product_weight_g real,
        product_length_cm real,
        product_height_cm real,
        product_width_cm real,
        primary key (product_id)
);


CREATE TABLE reviews_dataset (
        review_id varchar(200),
        order_id varchar(100),
        review_score int,
        review_comment_title varchar(100),
        review_comment_message varchar(400),
        review_creation_date timestamp,
        review_answer_timestamp timestamp,
        primary key(review_id),
        CONSTRAINT fk_order
      FOREIGN KEY(order_id) 
        REFERENCES order_dataset(order_id)
);


create table geolocation_dataset(
        geolocation_zip_code_prefix varchar(100) primary key,
        geolocation_lat real,
        geolocation_lng real,
        geolocation_city varchar(100),
        geolocation_state varchar(10)
);


create table sellers_dataset(
        seller_id varchar(200) primary key,
        seller_zip_code_prefix varchar(100),
        seller_city varchar(100),
        seller_state varchar(10),
        CONSTRAINT fk_zip_code_prefix
      FOREIGN KEY(seller_zip_code_prefix) 
        REFERENCES geolocation_dataset(geolocation_zip_code_prefix)
);


create table order_payments_dataset(
        order_id varchar(100),
        payment_sequential int,
        payment_type varchar(50),
        payment_installments varchar(100),
        payment_value real,
        CONSTRAINT fk_order_id
      FOREIGN KEY(order_id) 
        REFERENCES order_dataset(order_id)


);
with customer_per_month as (
select count((a.customer_id)) as total_customers,extract(MONTH FROM b.order_purchase_timestamp) as month_active, extract(YEAR FROM b.order_purchase_timestamp) as active_year
from `Ecom_data.customers` a
join `Ecom_data.orders` b
on  a.customer_id = b.customer_id
group by month_active,active_year
order by active_year, month_active
)
select ROUND((SUM(customer_per_month.total_customers)/count(month_active)),0) as average_active_user, active_year
from customer_per_month
group by active_year
order by active_year;


-- count new customer
WITH first_order_year AS (
  SELECT
    customer_id,
    MIN(EXTRACT(YEAR FROM order_purchase_timestamp)) AS first_purchase_year
  FROM `lustrous-strand-448007-h7`.`Ecom_data`.`orders`
  GROUP BY customer_id
),
new_customers_by_year AS (
  SELECT
    first_purchase_year AS year,
    COUNT(customer_id) AS new_customers
  FROM first_order_year
  GROUP BY year
)
SELECT
  year,
  new_customers
FROM new_customers_by_year
ORDER BY year;




--- check repeat order customer per year
SELECT
  customer_id,
  EXTRACT(YEAR FROM order_purchase_timestamp) AS active_year,
  COUNT(order_id) AS order_count
FROM `lustrous-strand-448007-h7`.`Ecom_data`.`orders`
GROUP BY customer_id, active_year
HAVING order_count > 1
ORDER BY active_year, customer_id;


-- calculate total revenue
with calculated_revenue as (
  SELECT a.order_id, (a.price + a.freight_value) as revenue, b.order_status,extract(year from b.order_purchase_timestamp) as year
  from `Ecom_data.order_items` a
  join `Ecom_data.orders` b
  on a.order_id = b.order_id
  where b.order_status = 'shipped'
)
select Round(sum(revenue),2) as Total_revenue, year
from calculated_revenue
group by year;


-- calculate order cancel


select count(order_id) as Canceled_order, extract(year from order_purchase_timestamp) as Year
from `Ecom_data.orders`
where order_status ='canceled'
group by Year;


-- top categories revenue
WITH revenue_categories AS (
  SELECT
    ROUND(SUM(a.price + a.freight_value), 2) AS revenue,
    a.product_id,
    EXTRACT(YEAR FROM b.order_purchase_timestamp) AS Year
  FROM `Ecom_data.order_items` a
  JOIN `Ecom_data.orders` b
    ON a.order_id = b.order_id
  WHERE b.order_status = 'shipped'
  GROUP BY a.product_id, Year
),
total_revenue_categories AS (
  SELECT
    SUM(a.revenue) AS total_revenue,
    b.product_category_name,
    a.Year
  FROM revenue_categories a
  JOIN `Ecom_data.products` b
    ON a.product_id = b.product_id
  GROUP BY b.product_category_name, a.Year
),
ranked_categories AS (
  SELECT
    total_revenue,
    product_category_name,
    Year,
    RANK() OVER (PARTITION BY Year ORDER BY total_revenue DESC) AS rank
  FROM total_revenue_categories
)
SELECT
  total_revenue AS top_revenue,
  product_category_name,
  Year
FROM ranked_categories
WHERE rank = 1
ORDER BY Year;


-- calculated cancel categories
with get_categories as (
select a.order_id, b.product_id,a.order_status, c.product_category_name, extract(year from a.order_purchase_timestamp) as year
from `Ecom_data.orders` a
left join `Ecom_data.order_items` b
on a.order_id = b.order_id
join `Ecom_data.products` c
on b.product_id = c.product_id
where a.order_status = 'canceled'
),
count_categories AS (
  SELECT
    COUNT(order_id) AS count_order,
    product_category_name,
    year
  FROM get_categories
  GROUP BY product_category_name, year
),
ranked_categories AS (
  SELECT
    count_order,
    product_category_name,
    year,
    RANK() OVER (PARTITION BY year ORDER BY count_order DESC) AS rank
  FROM count_categories
)
SELECT
  count_order AS most_canceled_orders,
  product_category_name,
  year
FROM ranked_categories
WHERE rank = 1
ORDER BY year;












-- count payments type
with customer_payment_type as (
  select a.order_id,a.customer_id, b.payment_type, extract(year from a.order_purchase_timestamp) as year
  from `Ecom_data.orders` a
  join `Ecom_data.order_payments` b
  on a.order_id = b.order_id
)
select count(customer_id) count_customer,payment_type, year
from customer_payment_type
group by payment_type, year
order by year asc;