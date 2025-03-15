CREATE DATABASE DB02_MANH;
USE DB02_MANH;

CREATE TABLE Category
(
    CategoryID CHAR(3) PRIMARY KEY,
    CategoryName VARCHAR(50)
) ;

CREATE TABLE Product
(
    ProductID CHAR(3) PRIMARY KEY,
    ProductName VARCHAR(50),
    UnitPrice INT CHECK(UnitPrice >= 0), 
    CategoryID CHAR(3)
); 


CREATE TABLE Invoice
(
    InvoiceID CHAR(3) PRIMARY KEY,
    InvoiceDate DATE,
    Description VARCHAR(255)
); 

CREATE TABLE InvoiceDetail (
    InvoiceID CHAR(3),
    ProductID CHAR(3), 
    Quantity INT CHECK( QUANTITY > 0), 
    PRIMARY KEY (InvoiceID, ProductID)
);

INSERT INTO Category VALUES 
('C01', 'ELECTRONICS'),
('C02', 'FURNITURE'),
('C03', 'CLOTHING'),
('C04', 'BOOKS'),
('C05', 'GROCERIES');

INSERT INTO Product VALUES 
('P01', 'LAPTOP', 1000, 'C01'),
('P02', 'SMARTPHONE', 800, 'C01'),
('P03', 'TV', 600, 'C01'),
('P04', 'DESK', 150, 'C02'),
('P05', 'CHAIR', 100, 'C02'),
('P06', 'SOFA', 400, 'C02'),
('P07', 'T-SHIRT', 20, 'C03'),
('P08', 'JEANS', 50, 'C03'),
('P09', 'JACKET', 80, 'C03'),
('P10', 'NOVEL', 15, 'C04'),
('P11', 'TEXTBOOK', 50, 'C04'),
('P12', 'MAGAZINE', 10, 'C04'),
('P13', 'RICE', 30, 'C05'),
('P14', 'MILK', 25, 'C05'),
('P15', 'BREAD', 5, 'C05'),
('P16', 'CAMERA', 700, 'C01'),
('P17', 'HEADPHONES', 120, 'C01'),
('P18', 'MOUSE', 40, 'C01'),
('P19', 'KEYBOARD', 60, 'C01'),
('P20', 'BOOKSHELF', 200, 'C02'),
('P21', 'WARDROBE', 300, 'C02'),
('P22', 'DRESS', 70, 'C03'),
('P23', 'SHOES', 90, 'C03'),
('P24', 'NOTEBOOK', 8, 'C04'),
('P25', 'PENCIL', 2, 'C04'),
('P26', 'EGGS', 10, 'C05'),
('P27', 'APPLES', 15, 'C05'),
('P28', 'ORANGE JUICE', 12, 'C05'),
('P29', 'MONITOR', 250, 'C01'),
('P30', 'LAMP', 35, 'C02');

INSERT INTO Invoice VALUES 
('I01', '2023-02-01', 'FIRST ORDER'),
('I02', '2023-03-02', 'SECOND ORDER'),
('I03', '2023-04-03', 'THIRD ORDER'),
('I04', '2023-05-04', 'FOURTH ORDER'),
('I05', '2023-06-05', 'FIFTH ORDER'),
('I06', '2023-07-06', 'SIXTH ORDER'),
('I07', '2023-08-07', 'SEVENTH ORDER'),
('I08', '2023-09-08', 'EIGHTH ORDER'),
('I09', '2023-10-09', 'NINTH ORDER'),
('I10', '2023-11-10', 'TENTH ORDER');

INSERT INTO InvoiceDetail VALUES 
('I01', 'P01', 1),
('I01', 'P02', 2),
('I02', 'P03', 1),
('I02', 'P04', 3),
('I02', 'P05', 1),
('I03', 'P06', 1),
('I03', 'P07', 2),
('I03', 'P08', 1),
('I04', 'P09', 2),
('I04', 'P10', 1),
('I05', 'P11', 1),
('I05', 'P12', 4),
('I06', 'P13', 2),
('I06', 'P14', 3),
('I07', 'P15', 5),
('I07', 'P16', 1),
('I08', 'P17', 2),
('I08', 'P18', 1),
('I08', 'P19', 3),
('I09', 'P20', 1),
('I09', 'P21', 2),
('I09', 'P22', 1),
('I10', 'P23', 1),
('I10', 'P24', 3),
('I10', 'P25', 2); 