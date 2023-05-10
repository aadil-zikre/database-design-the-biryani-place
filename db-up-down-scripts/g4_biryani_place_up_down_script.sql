IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'g4_biryani_place') 
    CREATE DATABASE g4_biryani_place
GO 

USE g4_biryani_place
GO

-- DOWN METADATA

IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_customers_customer_state')
    ALTER TABLE customers DROP CONSTRAINT fk_customers_customer_state

IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_orders_store_id')
    ALTER TABLE orders DROP CONSTRAINT fk_orders_store_id
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_orders_customer_id')
    ALTER TABLE orders DROP CONSTRAINT fk_orders_customer_id
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_orders_address_id')
    ALTER TABLE orders DROP CONSTRAINT fk_orders_address_id
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_orders_driver_id')
    ALTER TABLE orders DROP CONSTRAINT fk_orders_driver_id
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_orders_transaction_id')
    ALTER TABLE orders DROP CONSTRAINT fk_orders_transaction_id
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_order_details_order_id')
    ALTER TABLE order_details DROP CONSTRAINT fk_order_details_order_id
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_order_details_product_id')
    ALTER TABLE order_details DROP CONSTRAINT fk_order_details_product_id
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_addresses_customer_id')
    ALTER TABLE addresses DROP CONSTRAINT fk_addresses_customer_id
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_ratings_order_id')
    ALTER TABLE ratings DROP CONSTRAINT fk_ratings_order_id
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_drivers_store_id')
    ALTER TABLE drivers DROP CONSTRAINT fk_drivers_store_id
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_store_product_inventories_store_id')
    ALTER TABLE store_product_inventories DROP CONSTRAINT fk_store_product_inventories_store_id
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE constraint_name = 'fk_store_product_inventories_product_id')
    ALTER TABLE store_product_inventories DROP CONSTRAINT fk_store_product_inventories_product_id


DROP TABLE IF EXISTS orders
DROP TABLE IF EXISTS order_details
DROP TABLE IF EXISTS products
DROP TABLE IF EXISTS store_product_inventories
DROP TABLE IF EXISTS stores
DROP TABLE IF EXISTS customers
DROP TABLE IF EXISTS addresses
DROP TABLE IF EXISTS transactions
DROP TABLE IF EXISTS ratings 
DROP TABLE IF EXISTS drivers

GO

-- UP METADATA

CREATE TABLE orders (
    order_id	int IDENTITY	not null	,
    store_id	int	not null	,
    customer_id	int	not null	,
    address_id	int	null	,
    order_status	varchar(50)	not null	,
    order_type	varchar(50)	not null	,
    driver_id	int	null	,
    cart_amount	money	not null	,
    discount_amount	money	not null	,
    tax_amount	money	not null	,
    net_amount	money	not null	,
    payment_type	varchar(50)	not null	,
    transaction_id	int	not null	
    CONSTRAINT pk_orders_order_id PRIMARY KEY (order_id)
)

CREATE TABLE order_details(
    order_detail_id	int IDENTITY	not null	,
    order_id	int	not null	,
    product_id	int	not null	,
    quantity	int	not null	
    CONSTRAINT pk_order_details_order_detail_id PRIMARY KEY (order_detail_id),
    CONSTRAINT ck_order_details_quantity CHECK (quantity >= 0)
)

CREATE TABLE products(
    product_id	int IDENTITY	not null	,
    product_name	varchar(50)	not null	,
    category	varchar(50)	not null	,
    price	money	not null	,
    unit_of_measurement	varchar(50)	not null	
    CONSTRAINT pk_products_product_id PRIMARY KEY (product_id),
    CONSTRAINT ck_products_price CHECK (price >= 0)
)

CREATE TABLE store_product_inventories(
    store_id	int	not null	,
    product_id	int	not null	,
    quantity	int	not null	
    CONSTRAINT pk_store_product_inventories_store_id_product_id PRIMARY KEY (store_id, product_id)
    CONSTRAINT ck_store_product_inventories_quantity CHECK (quantity >= 0),
)

CREATE TABLE stores(
    store_id	int IDENTITY	not null	,
    store_name	varchar(50)	not null	,
    street	varchar(50)	not null	,
    city	varchar(50)	not null	,
    state	varchar(50)	not null	,
    zip_code	int	not null	,
    manager	varchar(50)	not null	
    CONSTRAINT pk_stores_store_id PRIMARY KEY (store_id),
    CONSTRAINT u_stores_manager UNIQUE (manager)
)

CREATE TABLE customers(
    customer_id	int IDENTITY	not null	,
    first_name	varchar(50)	not null	,
    last_name	varchar(50)	not null	,
    email	varchar(50)	not null	,
    phone_number	int	not null	,
    date_of_birth	varchar(50)	 null	,
    login_password	varchar(50)	not null	
    CONSTRAINT pk_customers_customer_id PRIMARY KEY (customer_id),
    CONSTRAINT u_customers_email UNIQUE (email)
)

CREATE TABLE addresses(
    address_id	int IDENTITY	not null	,
    customer_id	int	not null	,
    address_label	varchar(50)	not null	,
    house_number	varchar(50)	not null	,
    street	varchar(50)	not null	,
    city	varchar(50)	not null	,
    state	varchar(50)	not null	,
    zip_code	int	not null	
    CONSTRAINT pk_addresses_address_id PRIMARY KEY (address_id)
)

CREATE TABLE transactions(
    transaction_id	int IDENTITY	not null,
    transaction_status	varchar(50)	not null	
    CONSTRAINT pk_transactions_transaction_id PRIMARY KEY (transaction_id)
)

CREATE TABLE ratings(
    rating_id	int IDENTITY	not null	,
    order_id	int	not null	,
    order_rating	int	 null	,
    delivery_rating	int	 null	,
    feedback	nvarchar(500)	 null	
    CONSTRAINT pk_ratings_ratings_id PRIMARY KEY (rating_id)
)

CREATE TABLE drivers(
    driver_id	int IDENTITY	not null	,
    store_id	int	not null	,
    first_name	varchar(50)	not null	,
    last_name	varchar(50)	not null	,
    email_id	varchar(50)	not null	,
    phone_number	int	not null	
    CONSTRAINT pk_drivers_driver_id PRIMARY KEY (driver_id),
    CONSTRAINT u_drivers_email_id UNIQUE (email_id)
)

GO

ALTER TABLE orders 
    ADD CONSTRAINT fk_orders_store_id FOREIGN KEY (store_id) REFERENCES stores(store_id),
     CONSTRAINT fk_orders_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
     CONSTRAINT fk_orders_address_id FOREIGN KEY (address_id) REFERENCES addresses(address_id),
     CONSTRAINT fk_orders_driver_id FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
     CONSTRAINT fk_orders_transaction_id FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)

ALTER TABLE order_details 
    ADD CONSTRAINT fk_order_details_order_id FOREIGN KEY (order_id) REFERENCES orders(order_id),
     CONSTRAINT fk_order_details_product_id FOREIGN KEY (product_id) REFERENCES products(product_id)


ALTER TABLE addresses
    ADD CONSTRAINT fk_addresses_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id)

ALTER TABLE ratings 
    ADD CONSTRAINT fk_ratings_order_id FOREIGN KEY (order_id) REFERENCES orders(order_id)

ALTER TABLE drivers 
    ADD CONSTRAINT fk_drivers_store_id FOREIGN KEY (store_id) REFERENCES stores(store_id)

ALTER TABLE store_product_inventories
    ADD CONSTRAINT fk_store_product_inventories_store_id FOREIGN KEY (store_id) REFERENCES stores(store_id),
     CONSTRAINT fk_store_product_inventories_product_id FOREIGN KEY (product_id) REFERENCES products(product_id)
GO

-- UP DATA

INSERT INTO customers 
 (first_name, last_name, email, phone_number, date_of_birth,login_password)
VALUES 
('Helen', 'Heywater', 'hhywater@zmail.com', 8956516, '2/13/22','pass@123'),
('Jay', 'Walker', 'j.walker@zmail.com', 8956534, '9/13/21','pass@123')
GO

INSERT INTO stores 
 (store_name, street, city, state, zip_code,manager)
VALUES
('Ackerman FC','Ackerman Avenue','Syracuse','New York','13212','Kay Oss'),
('Westcott FC','Westcott Street','Syracuse','New York','13211','Jim Nasium'),
('Ostrom FC','Ostrom Avenue','Syracuse','New York','13210','Phil Landers')
GO

INSERT INTO products
(product_name,category,price,unit_of_measurement)
VALUES
('Hydrabadi Biryani','Spicy',25,'kg'),
('Lucknowi Biryani','Spicy',20,'kg'),
('Afghani Biryani','Sweet',15,'kg'),
('Kolkata Biryani','Spicy',22,'kg')

GO
INSERT INTO addresses
(customer_id,address_label,house_number,street,city,state,zip_code)
VALUES
(1,'Home',213,'Oakley St','Syracuse','New York','13215'),
(1,'Office',23,'Maple St','Syracuse','New York','13215'),
(2,'Office',22,'Maple St','Syracuse','New York','13215'),
(2,'Other',452,'Lincoln St','Syracuse','New York','13215')
GO

INSERT INTO drivers 
(store_id,first_name,last_name,email_id,phone_number)
VALUES
(1,'Tim','Burr','tburr@tbp.com',1234566),
(1,'Ty','Prayter','tprayter@tbp.com',1234566),
(1,'Zoltan','Zoltan','zpepper@tbp.com',1234566)
GO

INSERT INTO transactions
(transaction_status)
VALUES
('In Progress'),
('Success'),
('Success')

GO
INSERT INTO orders
(store_id,customer_id,address_id,order_status,order_type,driver_id,cart_amount,
discount_amount,tax_amount,net_amount,payment_type,transaction_id)
VALUES
(1,1,null,'delivered','pickup',null,45,0,3.6,48.6,'Cash',1),
(2,1,2,'cooking','delivery',2,30,5,2.4,27.4,'Card',2),
(3,2,3,'placed','delivery',3,111,0,8.88,119.88,'Card',3)
GO

INSERT INTO order_details
(order_id,product_id,quantity)
VALUES 
(1,1,1),
(1,2,1),
(2,3,2),
(3,1,2),
(3,2,2),
(3,4,3)
GO

INSERT into store_product_inventories
(store_id,product_id,quantity)
VALUES
(1,1,8),
(1,2,8),
(1,3,2),
(1,4,2),
(2,1,8),
(2,2,7),
(2,3,2),
(2,4,3),
(3,1,10),
(3,2,9),
(3,3,5),
(3,4,10)
GO

INSERT INTO ratings 
(order_id,order_rating,delivery_rating,feedback)
VALUES
(1,5,null,null),
(2,5,2,null),
(3,3,5,'Food was not hot')

GO

-- VERIFY DATA

SELECT * FROM orders
SELECT * FROM order_details
SELECT * FROM products
SELECT * FROM store_product_inventories
SELECT * FROM stores
SELECT * FROM customers
SELECT * FROM addresses
SELECT * FROM transactions
SELECT * FROM ratings 
SELECT * FROM drivers
GO 

-- UP VIEW

DROP VIEW IF EXISTS v_available_inventory
GO 

Create VIEW v_available_inventory as
    SELECT s.store_id,store_name,p.product_id,p.product_name,p.category,p.price,spi.quantity
    FROM store_product_inventories as spi
    LEFT JOIN stores as s ON spi.store_id = s.store_id
    LEFT JOIN products as p ON spi.product_id = p.product_id
    WHERE spi.quantity > 0
GO

-- UP STORED PROCEDURES

--     address_id	int IDENTITY	not null	,
--     customer_id	int	not null	,
--     address_label	varchar(50)	not null	,
--     house_number	varchar(50)	not null	,
--     street	varchar(50)	not null	,
--     city	varchar(50)	not null	,
--     state	varchar(50)	not null	,
--     zip_code	int	not null	

DROP PROCEDURE IF EXISTS dbo.p_insert_address
GO

CREATE PROCEDURE dbo.p_insert_address 
    @customer_id int, 
    @address_label nvarchar(50),
    @house_number varchar(50),
    @street varchar(50),
    @city varchar(50),
    @state varchar(50),
    @zip_code int 
AS
BEGIN
    BEGIN TRY 
        BEGIN TRANSACTION
        IF @zip_code BETWEEN 100000 AND 999999
            BEGIN
                INSERT INTO addresses (customer_id, address_label, house_number, street, city, "state", zip_code)
                    values (@customer_id, @address_label, @house_number, @street, @city, @state, @zip_code)
            IF @@ROWCOUNT <> 1 THROW 50001, 'p_insert_address failed', 1
            END 
        ELSE 
            BEGIN 
                PRINT 'zip_code invalid! Insert not possible'
            END 
        COMMIT 
    END TRY 
    BEGIN CATCH 
        ROLLBACK 
        ;
        THROW 
    END CATCH
END
GO

DROP PROCEDURE IF EXISTS dbo.p_increment_order_status
GO

CREATE PROCEDURE dbo.p_increment_order_status 
    @order_id int
AS
BEGIN
    BEGIN TRY 
        BEGIN TRANSACTION
        IF EXISTS (SELECT * FROM orders where order_id = @order_id)
            BEGIN
                declare @new_status VARCHAR(50)
                SELECT @new_status = CASE WHEN order_status = 'placed' THEN 'cooking' 
                                        WHEN order_status = 'cooking' THEN 'out_for_delivery'
                                        ELSE 'delivered' END 
                    FROM orders where order_id = @order_id
                UPDATE orders 
                    SET order_status = @new_status
                    WHERE order_id = @order_id

            IF @@ROWCOUNT <> 1 THROW 50001, 'p_increment_order_status failed', 1
            END 
        ELSE 
            BEGIN 
                PRINT 'order_id invalid! Order not placed yet.'
            END 
        COMMIT 
    END TRY 
    BEGIN CATCH 
        ROLLBACK 
        ;
        THROW 
    END CATCH
END
GO