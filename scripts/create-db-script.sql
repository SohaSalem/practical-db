CREATE TABLE "category" (
  "category_id" uuid PRIMARY KEY,
  "category_name" varchar(100)
);

CREATE TABLE "product" (
  "product_id" uuid PRIMARY KEY,
  "category_id" uuid,
  "name" varchar(100),
  "description" varchar(255),
  "price" int,
  "stock_quantity" int
);

CREATE TABLE "product_category" (
  "id" uuid PRIMARY KEY,
  "product_id" uuid,
  "category_id" uuid
);

CREATE TABLE "customer" (
  "customer_id" uuid PRIMARY KEY,
  "first_name" varchar(100),
  "last_name" varchar(100),
  "email" varchar(100),
  "password" varchar(255)
);

CREATE TABLE "order" (
  "order_id" uuid PRIMARY KEY,
  "customer_id" uuid,
  "order_date" timestamp,
  "total_amount" int
);

CREATE TABLE "order_details" (
  "order_detail_id" uuid PRIMARY KEY,
  "order_id" uuid,
  "product_id" uuid,
  "quantity" int,
  "unit_price" float
);

ALTER TABLE "product_category" ADD FOREIGN KEY ("category_id") REFERENCES "category" ("category_id");

ALTER TABLE "product_category" ADD FOREIGN KEY ("product_id") REFERENCES "product" ("product_id");

ALTER TABLE "order_details" ADD FOREIGN KEY ("product_id") REFERENCES "product" ("product_id");

ALTER TABLE "category" ADD FOREIGN KEY ("category_id") REFERENCES "category" ("category_id");

ALTER TABLE "order" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("customer_id");

ALTER TABLE "order_details" ADD FOREIGN KEY ("order_id") REFERENCES "order" ("order_id");
