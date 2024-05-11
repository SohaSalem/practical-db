-- Generate fake data for category table
INSERT INTO "category" ("category_id", "category_name")
VALUES
  (uuid_generate_v4(), 'Electronics'),
  (uuid_generate_v4(), 'Clothing'),
  (uuid_generate_v4(), 'Books'),
  (uuid_generate_v4(), 'Home & Garden');

-- Generate fake data for product table
INSERT INTO "product" ("product_id", "category_id", "name", "description", "price", "stock_quantity")
SELECT
  uuid_generate_v4(),
  "category_id",
  concat("category_name", ' Product ', generate_series(1, 5)),
  concat("category_name", ' Product Description'),
  (random() * 1000)::int,
  (random() * 100)::int
FROM "category"
CROSS JOIN generate_series(1, 5);

-- Generate fake data for customer table
INSERT INTO "customer" ("customer_id", "first_name", "last_name", "email", "password")
SELECT
  uuid_generate_v4(),
  substr(encode(gen_random_bytes(6), 'hex'), 1, 6),
  substr(encode(gen_random_bytes(8), 'hex'), 1, 8),
  concat(
    substr(encode(gen_random_bytes(4), 'hex'), 1, 4),
    generate_series(1, 6),
    '@example.com'
  ),
  md5(concat('password', generate_series(1, 10)))
FROM generate_series(1, 10); 


-- Generate fake data for order table
INSERT INTO "order" ("order_id", "customer_id", "order_date", "total_amount")
SELECT
  uuid_generate_v4(),
  "customer_id",
  CURRENT_TIMESTAMP - (random() * interval '365 days'),
  (random() * 1000)::int
FROM "customer"
CROSS JOIN generate_series(1, 20);

-- Generate fake data for order_details table
INSERT INTO "order_details" ("order_detail_id", "order_id", "product_id", "quantity", "unit_price")
SELECT
  uuid_generate_v4(),
  "order_id",
  "product_id",
  (random() * 5)::int + 1,
  ("price" * (random() * 0.5 + 0.5))
FROM "order"
CROSS JOIN "product"
CROSS JOIN generate_series(1, 3);