-- Active: 1741454255232@@127.0.0.1@3306@db04_manh
CREATE DATABASE DB04_MANH; 
USE DB04_MANH;

CREATE TABLE CATEGORY 
(
    CATEGORY_ID CHAR(3) PRIMARY KEY,
    CATEGORY_NAME VARCHAR(50)
) ;

CREATE TABLE PRODUCT
(
    PRODUCT_ID CHAR(3) PRIMARY KEY,
    PRODUCT_NAME VARCHAR(50),
    UNIT_PRICE INT CHECK(UNIT_PRICE >= 0),
    CATEGORY_ID CHAR(3),
    FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID) 
);

CREATE TABLE CUSTOMER 
(
    CUSTOMER_ID CHAR(3) PRIMARY KEY,
    CUSTOMER_NAME VARCHAR(50),
    CUSTOMER_ADDRESS VARCHAR(100)
);

CREATE TABLE ORDERS
(
    ORDER_ID CHAR(3) PRIMARY KEY,
    ORDER_DATE DATE,
    REQUIRED_DATE DATE,
    CUSTOMER_ID CHAR(3),
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID), 
    CHECK(ORDER_DATE <= REQUIRED_DATE)
); 

CREATE TABLE ORDER_DETAIL
(
    ORDER_ID CHAR(3),
    PRODUCT_ID CHAR(3),
    ORDER_QUANTITY INT CHECK(ORDER_QUANTITY > 0),
    PRIMARY KEY(ORDER_ID, PRODUCT_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID),
    FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID)
);

CREATE TABLE DELIVERY
(
    DELIVERY_ID CHAR(3) PRIMARY KEY,
    DELIVERY_DATE DATE,
    ORDER_ID CHAR(3),
    FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ORDER_ID)
);

CREATE TABLE DELIVERY_DETAIL
(
    DELIVERY_ID CHAR(3),
    PRODUCT_ID CHAR(3),
    DELIVERY_QUANTITY INT CHECK(DELIVERY_QUANTITY > 0),
    PRIMARY KEY(DELIVERY_ID, PRODUCT_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID),
    FOREIGN KEY (DELIVERY_ID) REFERENCES DELIVERY(DELIVERY_ID)
); 
INSERT INTO CATEGORY VALUES
('C01', 'ELECTRONICS'),
('C02', 'CLOTHING'),
('C03', 'FURNITURE'),
('C04', 'FOOD'),
('C05', 'DRINK');

INSERT INTO PRODUCT VALUES
('P01', 'LAPTOP', 1000, 'C01'),
('P02', 'SMARTPHONE', 800, 'C01'),
('P03', 'T-SHIRT', 20, 'C02'),
('P04', 'JEANS', 50, 'C02'),
('P05', 'SOFA', 500, 'C03'),
('P06', 'TABLE', 300, 'C03'),
('P07', 'BEEF', 10, 'C04'),
('P08', 'CHICKEN', 8, 'C04'),
('P09', 'COCA COLA', 2, 'C05'),
('P10', 'PEPSI', 2, 'C05'); 

INSERT INTO CUSTOMER VALUES
('U01', 'JOHN', '123 MAIN ST, CITY A'),
('U02', 'JANE', '456 MARKET ST, CITY B'),
('U03', 'JACK', '789 OAK ST, CITY C'),
('U04', 'JILL', '101 ELM ST, CITY D'),
('U05', 'JAMES', '202 PINE ST, CITY E');

INSERT INTO ORDERS VALUES
('O01', '2025-01-01', '2025-01-05', 'U01'),
('O02', '2022-01-02', '2022-01-06', 'U02'),
('O03', '2022-01-03', '2022-01-07', 'U03'),
('O04', '2025-01-04', '2025-01-08', 'U04'),
('O05', '2022-01-05', '2022-01-09', 'U05');


INSERT INTO ORDER_DETAIL VALUES
('O01', 'P01', 5),
('O01', 'P02', 3),
('O02', 'P03', 10),
('O02', 'P01', 8),
('O03', 'P05', 2),
('O03', 'P01', 1),
('O03', 'P02', 1),
('O03', 'P06', 1),
('O04', 'P07', 3),
('O04', 'P08', 5),
('O05', 'P09', 10),
('O05', 'P10', 10);

INSERT INTO DELIVERY VALUES
('D01', '2025-01-06', 'O01'),
('D02', '2022-01-07', 'O02'),
('D03', '2022-01-08', 'O03'),
('D04', '2025-01-09', 'O04'),
('D05', '2022-01-10', 'O05');

INSERT INTO DELIVERY_DETAIL VALUES
('D01', 'P01', 5),
('D01', 'P02', 3),
('D02', 'P03', 10),
('D02', 'P01', 8),
('D03', 'P05', 2),
('D03', 'P01', 1),
('D03', 'P02', 1),
('D03', 'P06', 1),
('D04', 'P07', 3),
('D04', 'P08', 5),
('D05', 'P09', 10),
('D05', 'P10', 10);

SELECT * 
FROM PRODUCT 
WHERE CATEGORY_ID = 'C02';

SELECT CUS.*
FROM CUSTOMER AS CUS 
JOIN ORDERS AS ORDS ON ORDS.CUSTOMER_ID = CUS.CUSTOMER_ID
WHERE ORDER_DATE > '2022-01-01' AND ORDER_DATE < '2022-01-05'; 

SELECT CUS.* 
FROM CUSTOMER AS CUS
JOIN ORDERS AS ORDS ON ORDS.CUSTOMER_ID = CUS.CUSTOMER_ID
WHERE YEAR(ORDER_DATE) = 2025;

SELECT PRODUCT_ID
FROM ORDER_DETAIL
WHERE ORDER_ID = 'O01';

SELECT PRO.* 
FROM PRODUCT AS PRO
JOIN ORDER_DETAIL AS ORDD ON ORDD.PRODUCT_ID = PRO.PRODUCT_ID
WHERE ORDD.ORDER_ID = 'O01';

SELECT PRO.*
FROM PRODUCT AS PRO
JOIN ORDER_DETAIL AS ORDD ON ORDD.PRODUCT_ID = PRO.PRODUCT_ID
JOIN ORDERS AS ORDS ON ORDS.ORDER_ID = ORDD.ORDER_ID
WHERE ORDER_DATE = '2022-01-02';

SELECT ORDER_ID, SUM(ORDER_QUANTITY) AS TOTAL_QUANTITY
FROM ORDER_DETAIL 
GROUP BY ORDER_ID; 

SELECT ORDD.ORDER_ID, SUM(ORDD.ORDER_QUANTITY) AS TOTAL_QUANTITY
FROM ORDER_DETAIL AS ORDD
JOIN ORDERS AS ORDS ON ORDS.ORDER_ID = ORDD.ORDER_ID
WHERE YEAR(ORDER_DATE) = 2025
GROUP BY ORDD.ORDER_ID;

SELECT ORDD.ORDER_ID, SUM(ORDD.ORDER_QUANTITY) AS TOTAL_QUANTITY
FROM ORDER_DETAIL AS ORDD
JOIN ORDERS AS ORDS ON ORDS.ORDER_ID = ORDD.ORDER_ID
GROUP BY ORDD.ORDER_ID
HAVING TOTAL_QUANTITY =
(SELECT MAX(SUB.TOTAL)
FROM (
    SELECT ORDD.ORDER_ID, SUM(ORDD.ORDER_QUANTITY) AS TOTAL
    FROM ORDER_DETAIL AS ORDD
    JOIN ORDERS AS ORDS ON ORDS.ORDER_ID = ORDD.ORDER_ID
    GROUP BY ORDD.ORDER_ID
) AS SUB);

SELECT ORDD.ORDER_ID, SUM(ORDD.ORDER_QUANTITY) AS TOTAL_QUANTITY
FROM ORDER_DETAIL AS ORDD
JOIN ORDERS AS ORDS ON ORDS.ORDER_ID = ORDD.ORDER_ID
WHERE YEAR(ORDER_DATE) = 2025
GROUP BY ORDD.ORDER_ID
HAVING TOTAL_QUANTITY =
(SELECT MAX(SUB.TOTAL)
FROM (
    SELECT ORDD.ORDER_ID, SUM(ORDD.ORDER_QUANTITY) AS TOTAL
    FROM ORDER_DETAIL AS ORDD
    JOIN ORDERS AS ORDS ON ORDS.ORDER_ID = ORDD.ORDER_ID
    WHERE YEAR(ORDER_DATE) = 2025
    GROUP BY ORDD.ORDER_ID
) AS SUB);

