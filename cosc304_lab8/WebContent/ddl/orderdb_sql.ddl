CREATE DATABASE orders;
go;

USE orders;
go;

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    isadmin             INT,
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Fish');
INSERT INTO category(categoryName) VALUES ('Mammals');
INSERT INTO category(categoryName) VALUES ('Birds');
INSERT INTO category(categoryName) VALUES ('Reptiles');
INSERT INTO category(categoryName) VALUES ('Amphibians');
INSERT INTO category(categoryName) VALUES ('Dragons');
INSERT INTO category(categoryName) VALUES ('Fairies');
INSERT INTO category(categoryName) VALUES ('Dinosaurs');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Killer Whale', 1, 'Gentle giant perfect for backyard pool!',1800.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Swordfish',1,'Mature swordfish, loves rice!',19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Lion',2,'huge mane',1310.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Tiger',2,'tiger',1022.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Zebra',2,'stripey',821.35);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Wolverine',2,'straight from the movie',1025.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sasquatch',2,'very rare',10330.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Black Bear',2,'very friendly',1040.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Capybara',2,'The goat',907.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Giraffe',2,'extra long neck',5438.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hawk',3,'great flyer',23.25);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Parrot',3,'Speaking parrot',15.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bald Eagle',3,'Murica',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Quail',3,'pretty standard',39.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Surveillance Pigeon',3,'keeps watch',62.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Alligator',4,'Doesnt bite',1009.20);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Anaconda',4,'My anaconda dont',81.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Chameleon',4,'Chameleon',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('King Cobra',4,'King Cobra',21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Komodo Dragon',4,'komodo dragon',140.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Frog',5,'magical frog',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Axolotl',5,'friendly guy',19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Fiery Dragon',6,'Fiery Dragon',450018.40);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Green Fairy',7,'Green fairy',9.65);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Blue Fairy',7,'Blue Fairy',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('T-rex',8,'T-rex',21023.05);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Velociraptor',8,'Velociraptor ',1400.00);

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 9000);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 190);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 3930);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 2044);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 4928.10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 3075);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 10330);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 3, 3120);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 1814);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 16314);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, isadmin) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test', 1);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 8800)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 1800)

INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 1642)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 5438);
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 7080.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 4106.75);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 33050.00)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 2050)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30990)

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 11,288.05)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 5240)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 3120)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 52.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 27, 2, 2800)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 22, 4, 76);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 3747.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 3285.40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 42)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 420);

-- New SQL DDL for ALL IMAGES
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/6.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/7.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/8.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/9.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/10.jpg' WHERE ProductId = 10; 
UPDATE Product SET productImageURL = 'img/11.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/12.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/13.jpg' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/14.jpg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/15.jpg' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'img/16.jpg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/17.jpg' WHERE ProductId = 17;
UPDATE Product SET productImageURL = 'img/18.jpg' WHERE ProductId = 18;
UPDATE Product SET productImageURL = 'img/19.jpg' WHERE ProductId = 19;
UPDATE Product SET productImageURL = 'img/20.jpg' WHERE ProductId = 20; 
UPDATE Product SET productImageURL = 'img/21.jpg' WHERE ProductId = 21;
UPDATE Product SET productImageURL = 'img/22.webp' WHERE ProductId = 22;
UPDATE Product SET productImageURL = 'img/23.jpg' WHERE ProductId = 23;
UPDATE Product SET productImageURL = 'img/24.jpg' WHERE ProductId = 24;
UPDATE Product SET productImageURL = 'img/25.jpg' WHERE ProductId = 25; 
UPDATE Product SET productImageURL = 'img/26.jpg' WHERE ProductId = 26;
UPDATE Product SET productImageURL = 'img/27.jpg' WHERE ProductId = 27;

