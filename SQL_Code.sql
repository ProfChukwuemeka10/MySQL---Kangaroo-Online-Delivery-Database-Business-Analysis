-- KANGAROO ONLINE DELIVERY COMPANY
-- RELATIONAL DATABASE MANAGEMENT SYSTEM

-- 1. Kangaroo_DB Database
DROP DATABASE IF EXISTS Kangaroo_DB;
CREATE DATABASE Kangaroo_DB;
USE Kangaroo_DB;

-- 2. Manager table
CREATE TABLE Manager (
    ManagerID INT AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),

    PRIMARY KEY (ManagerID)
);

-- 3. Restaurant Table
CREATE TABLE Restaurant (
    RestaurantID INT AUTO_INCREMENT,
    RestaurantName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,

    PRIMARY KEY (RestaurantID)
);

-- 4. Category Table
CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,

    PRIMARY KEY (CategoryID)
);

-- 5. Customer Table
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber VARCHAR(20),

    PRIMARY KEY (CustomerID)
);

-- 6. Motorbike Table
CREATE TABLE Motorbike (
    MotorbikeID INT AUTO_INCREMENT,
    RegistrationNo VARCHAR(20) NOT NULL UNIQUE,
    Colour VARCHAR(30) NOT NULL,
    PurchaseDate DATE NOT NULL,
    EngineSize INT NOT NULL,

    PRIMARY KEY (MotorbikeID),

    CONSTRAINT chk_engine_size
        CHECK (EngineSize > 0)
);

-- 7. Driving License Table
CREATE TABLE Driving_License (
    LicenseID INT AUTO_INCREMENT,
    LicenseNumber VARCHAR(50) NOT NULL UNIQUE,
    IssueDate DATE NOT NULL,
    CountryOfIssue VARCHAR(100) NOT NULL,
    ExpiryDate DATE NOT NULL,

    PRIMARY KEY (LicenseID),

    CONSTRAINT chk_license_dates
        CHECK (ExpiryDate > IssueDate)
);

-- 8. Item Table
CREATE TABLE Item (
    ItemID INT AUTO_INCREMENT,
    ItemName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,

    PRIMARY KEY (ItemID),

    CONSTRAINT fk_item_category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 9. Driver Table
CREATE TABLE Driver (
    DriverID INT AUTO_INCREMENT,
    NIN_Number VARCHAR(20) NOT NULL UNIQUE,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,

    ManagerID INT NOT NULL,
    RestaurantID INT NOT NULL,
    MotorbikeID INT NOT NULL UNIQUE,
    LicenseID INT NOT NULL UNIQUE,

    PRIMARY KEY (DriverID),

    CONSTRAINT chk_driver_salary
        CHECK (Salary >= 0),

    CONSTRAINT fk_driver_manager
        FOREIGN KEY (ManagerID)
        REFERENCES Manager(ManagerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_driver_restaurant
        FOREIGN KEY (RestaurantID)
        REFERENCES Restaurant(RestaurantID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_driver_motorbike
        FOREIGN KEY (MotorbikeID)
        REFERENCES Motorbike(MotorbikeID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_driver_license
        FOREIGN KEY (LicenseID)
        REFERENCES Driving_License(LicenseID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 10. Restaurant_Item Table
CREATE TABLE Restaurant_Item (
    RestaurantID INT NOT NULL,
    ItemID INT NOT NULL,
    CurrentPrice DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (RestaurantID, ItemID),

    CONSTRAINT chk_restaurant_item_price
        CHECK (CurrentPrice >= 0),

    CONSTRAINT fk_ri_restaurant
        FOREIGN KEY (RestaurantID)
        REFERENCES Restaurant(RestaurantID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_ri_item
        FOREIGN KEY (ItemID)
        REFERENCES Item(ItemID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 11. Orders Table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CustomerID INT NOT NULL,
    RestaurantID INT NOT NULL,
    DriverID INT NOT NULL,

    PRIMARY KEY (OrderID),

    CONSTRAINT fk_order_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_order_restaurant
        FOREIGN KEY (RestaurantID)
        REFERENCES Restaurant(RestaurantID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_order_driver
        FOREIGN KEY (DriverID)
        REFERENCES Driver(DriverID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 12. Order Item Table
CREATE TABLE Order_Item (
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    UnitPrice DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (OrderID, ItemID),

    CONSTRAINT chk_order_quantity
        CHECK (Quantity > 0),

    CONSTRAINT chk_order_unit_price
        CHECK (UnitPrice >= 0),

    CONSTRAINT fk_orderitem_order
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_orderitem_item
        FOREIGN KEY (ItemID)
        REFERENCES Item(ItemID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

SHOW TABLES;

INSERT INTO Category
(CategoryName)
VALUES
('Starter'),
('Main Course'),
('Desserts'),
('Drinks');

INSERT INTO Customer
(FirstName, LastName, Email, PhoneNumber)
VALUES
('Miracle', 'Anderson', 'miracle.anderson@gmail.com', '9012345112'),
('Emeka', 'Brown', 'emeka.brown@gmail.com', '90103450002'),
('Daniel', 'Wilson', 'daniel.wilson@gmail.com', '9012775012'),
('Olivia', 'Taylor', 'olivia.taylor@gmail.com', '90790050004'),
('Michael', 'Thomas', 'michael.thomas@gmail.com', '9011234505'),
('Sophia', 'Stephen', 'sophia.stephen@gmail.com', '906143459906'),
('William', 'Martin', 'william.martin@gmail.com', '23471234500'),
('Grace', 'Jackson', 'grace.jackson@gmail.com', '2331234008'),
('Henry', 'White', 'henry.white@gmail.com', '319071234509'),
('Amara', 'Uka', 'amara.uka@gmail.com', '1023450010');

INSERT INTO Restaurant
(RestaurantName, Address)
VALUES
('Chitis', '12 High Street, Australia'),
('Alex Kitchen', '25 Oxford Street, London'),
('Pizza House', '21 Market Street, Tokyo'),
('Burger Site', '42 New Street, Australia'),
('Tasty Cookies', '15 Park Row, Nigeria'),
('Urban Store', '30 Broad Street, Bristol'),
('Sweets', '21 Church Street, Bristol'),
('Chicken Bites', '17 Division Street, Boston'),
('Fresh Cookies', '10 Derby Road, Nottingham'),
('City Food Hub', '8 Grey Street, Newcastle');

INSERT INTO Manager
(FirstName, LastName, Email, Phone)
VALUES
('Jon', 'Mich', 'jon.mich@gmail.com', '900123456'),
('Sarah', 'Okoh', 'sarah.okoh@gmail.com', '9072000002'),
('David', 'Williams', 'david.williams@gmail.com', '123490003'),
('Emma', 'John', 'emma.john@gmail.com', '2180720894'),
('John', 'Evans', 'john.evans@gmail.com', '2330720005'),
('Lucy', 'Tim', 'lucy.tim@gmail.com', '23407212306'),
('Peter', 'Roberts', 'peter.roberts@gmail.com', '9011127897'),
('Anna', 'Johnson', 'anna.johnson@gmail.com', '2128728008'),
('Mark', 'Walker', 'mark.walker@gmail.com', '12345678998'),
('Laura', 'Nike', 'laura.nike@gmail.com', '22317276510');

INSERT INTO Item
(ItemName, CategoryID)
VALUES
('Garlic Bread', 1),
('Chicken Wings', 1),
('Margherita Pizza', 2),
('Pepperoni Pizza', 2),
('Chicken Burger', 2),
('Beef Burger', 2),
('Chocolate Cake', 3),
('Cheesecake', 3),
('Cola', 4),
('Orange Juice', 4);

INSERT INTO Motorbike
(RegistrationNo, Colour, PurchaseDate, EngineSize)
VALUES
('GAR01ABC', 'Black', '2024-01-15', 125),
('AB02DEF', 'Red', '2024-02-20', 150),
('GG03GHI', 'Blue', '2024-03-12', 125),
('GL04JKL', 'White', '2024-04-10', 150),
('ABJ5MNO', 'Black', '2024-05-18', 125),
('GH06PQR', 'Silver', '2024-06-22', 150),
('KK07STU', 'Red', '2024-07-14', 125),
('KR08VWX', 'Blue', '2024-08-19', 150),
('KR09YZA', 'White', '2024-09-11', 125),
('KR10BCD', 'Black', '2024-10-25', 150);

INSERT INTO Driving_License
(LicenseNumber, IssueDate, CountryOfIssue, ExpiryDate)
VALUES
('AA100001', '2022-01-10', 'United Kingdom', '2032-01-10'),
('AA100002', '2022-02-15', 'United Kingdom', '2032-02-15'),
('AA100003', '2022-03-20', 'United Kingdom', '2032-03-20'),
('AA100004', '2022-04-25', 'United Kingdom', '2032-04-25'),
('AA100005', '2022-05-30', 'United Kingdom', '2032-05-30'),
('AA100006', '2022-06-12', 'United Kingdom', '2032-06-12'),
('AA100007', '2022-07-18', 'United Kingdom', '2032-07-18'),
('AA100008', '2022-08-21', 'United Kingdom', '2032-08-21'),
('AA100009', '2022-09-15', 'United Kingdom', '2032-09-15'),
('AA100010', '2022-10-20', 'United Kingdom', '2032-10-20');

INSERT INTO Driver
(
    FirstName,
    LastName,
    Salary,
    Email,
    NIN_Number,
    ManagerID,
    RestaurantID,
    MotorbikeID,
    LicenseID
)
VALUES
('Clifford', 'Eke', 10000, 'clifford.eke@gmail.com',
 'AZ100000A', 1, 1, 1, 1),
('Ben', 'George', 18000, 'ben.george@gmail.com',
 'AZ100001B', 2, 2, 2, 2),
('Chris', 'Rob', 19000, 'chris.rob@gmail.com',
 'AZ100002C', 3, 3, 3, 3),
('Daniel', 'Walker', 29500, 'daniel.walker@gmail.com',
 'AZ100003D', 4, 4, 4, 4),
('Edward', 'Frank', 10000, 'edward.hall@gmail.com',
 'AZ100004E', 5, 5, 5, 5),
('Frank', 'Mose', 30500, 'frank.allen@gmail.com',
 'AZ100005F', 6, 6, 6, 6),
('George', 'Young', 31000, 'george.young@gmail.com',
 'AZ100006G', 7, 7, 7, 7),
('Harry', 'King', 31500, 'harry.king@gmail.com',
 'AZ100007H', 8, 8, 8, 8),
('Ian', 'Mine', 32000, 'ian.mine@gmail.com',
 'AZ100008I', 9, 9, 9, 9),
('Jack', 'Green', 32500, 'jack.green@gmail.com',
 'AZ100009J', 10, 10, 10, 10);

INSERT INTO Restaurant_Item
(RestaurantID, ItemID, CurrentPrice)
VALUES

-- RESTAURANT 1
(1, 1, 3.50),
(1, 2, 5.50),
(1, 3, 8.50),
(1, 4, 10.50),
(1, 5, 7.50),
(1, 6, 9.50),
(1, 7, 6.50),
(1, 8, 7.50),
(1, 9, 2.50),
(1, 10, 3.50),

-- RESTAURANT 2
(2, 1, 4.00),
(2, 2, 6.00),
(2, 3, 9.00),
(2, 4, 11.00),
(2, 5, 8.00),
(2, 6, 10.00),
(2, 7, 7.00),
(2, 8, 8.00),
(2, 9, 3.00),
(2, 10, 4.00),

-- RESTAURANT 3
(3, 1, 3.75),
(3, 2, 5.75),
(3, 3, 8.75),
(3, 4, 10.75),
(3, 5, 7.75),
(3, 6, 9.75),
(3, 7, 6.75),
(3, 8, 7.75),
(3, 9, 2.75),
(3, 10, 3.75),

-- RESTAURANT 4
(4, 1, 4.25),
(4, 2, 6.25),
(4, 3, 9.25),
(4, 4, 11.25),
(4, 5, 8.25),
(4, 6, 10.25),
(4, 7, 7.25),
(4, 8, 8.25),
(4, 9, 3.25),
(4, 10, 4.25),

-- RESTAURANT 5
(5, 1, 3.25),
(5, 2, 5.25),
(5, 3, 8.25),
(5, 4, 10.25),
(5, 5, 7.25),
(5, 6, 9.25),
(5, 7, 6.25),
(5, 8, 7.25),
(5, 9, 2.25),
(5, 10, 3.25);

INSERT INTO Orders
(OrderDate, CustomerID, RestaurantID, DriverID)
VALUES
('2026-01-05 10:15:00', 1, 1, 1),
('2026-01-06 11:30:00', 2, 2, 2),
('2026-01-07 12:45:00', 3, 3, 3),
('2026-01-08 13:20:00', 4, 4, 4),
('2026-01-09 14:10:00', 5, 5, 5),
('2026-01-10 15:25:00', 6, 1, 1),
('2026-01-11 16:40:00', 7, 2, 2),
('2026-01-12 17:05:00', 8, 3, 3),
('2026-01-13 18:15:00', 9, 4, 4),
('2026-01-14 19:30:00', 10, 5, 5),
('2026-01-15 10:45:00', 1, 2, 2),
('2026-01-16 11:50:00', 2, 3, 3),
('2026-01-17 12:35:00', 3, 4, 4),
('2026-01-18 13:40:00', 4, 5, 5),
('2026-01-19 14:55:00', 5, 1, 1);

INSERT INTO Order_Item
(OrderID, ItemID, Quantity, UnitPrice)
VALUES

-- ORDER 1
(1, 1, 2, 3.50),
(1, 3, 1, 8.50),

-- ORDER 2
(2, 2, 2, 6.00),
(2, 5, 1, 8.00),

-- ORDER 3
(3, 3, 1, 8.75),
(3, 4, 2, 10.75),

-- ORDER 4
(4, 5, 1, 8.25),
(4, 6, 2, 10.25),

-- ORDER 5
(5, 7, 2, 6.25),
(5, 9, 1, 2.25),

-- ORDER 6
(6, 1, 1, 3.50),
(6, 8, 1, 7.50),

-- ORDER 7
(7, 4, 2, 11.00),
(7, 10, 2, 4.00),

-- ORDER 8
(8, 3, 1, 8.75),
(8, 7, 1, 6.75),

-- ORDER 9
(9, 6, 1, 10.25),
(9, 9, 2, 3.25),

-- ORDER 10
(10, 2, 1, 5.25),
(10, 8, 2, 7.25),

-- ORDER 11
(11, 5, 2, 8.00),
(11, 10, 1, 4.00),

-- ORDER 12
(12, 4, 1, 10.75),
(12, 7, 2, 6.75),

-- ORDER 13
(13, 6, 2, 10.25),
(13, 3, 1, 9.25),

-- ORDER 14
(14, 8, 1, 7.25),
(14, 9, 2, 2.25),

-- ORDER 15
(15, 1, 2, 3.50),
(15, 5, 1, 7.50);

SHOW TABLES;

SELECT * FROM Manager;

SELECT * FROM Restaurant;

SELECT * FROM Category;

SELECT * FROM Customer;

SELECT * FROM Motorbike;

SELECT * FROM Driving_License;

SELECT * FROM Item;

SELECT * FROM Driver;

SELECT * FROM Restaurant_Item;

SELECT * FROM Orders;

SELECT * FROM Order_Item;


SELECT 'Manager' AS TableName, COUNT(*) AS NumberOfRecords
FROM Manager
UNION ALL

SELECT 'Restaurant', COUNT(*)
FROM Restaurant

UNION ALL

SELECT 'Category', COUNT(*)
FROM Category

UNION ALL

SELECT 'Customer', COUNT(*)
FROM Customer

UNION ALL

SELECT 'Motorbike', COUNT(*)
FROM Motorbike

UNION ALL

SELECT 'Driving_License', COUNT(*)
FROM Driving_License

UNION ALL

SELECT 'Item', COUNT(*)
FROM Item

UNION ALL

SELECT 'Driver', COUNT(*)
FROM Driver

UNION ALL

SELECT 'Restaurant_Item', COUNT(*)
FROM Restaurant_Item

UNION ALL

SELECT 'Orders', COUNT(*)
FROM Orders

UNION ALL

SELECT 'Order_Item', COUNT(*)
FROM Order_Item;

-- CUSTOMER ORDER ANALYSIS
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(o.OrderID) AS NumberOfOrders
FROM Customer c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY NumberOfOrders DESC;


-- ORDER DETAILS
SELECT
    o.OrderID,
    o.OrderDate,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    r.RestaurantName,
    CONCAT(d.FirstName, ' ', d.LastName) AS DriverName
FROM Orders o
JOIN Customer c
    ON o.CustomerID = c.CustomerID
JOIN Restaurant r
    ON o.RestaurantID = r.RestaurantID
JOIN Driver d
    ON o.DriverID = d.DriverID
ORDER BY o.OrderID;

-- ORDER ITEM DETAILS
SELECT
    o.OrderID,
    o.OrderDate,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    r.RestaurantName,
    i.ItemName,
    oi.Quantity,
    oi.UnitPrice,
    (oi.Quantity * oi.UnitPrice) AS LineTotal
FROM Orders o
JOIN Customer c
    ON o.CustomerID = c.CustomerID
JOIN Restaurant r
    ON o.RestaurantID = r.RestaurantID
JOIN Order_Item oi
    ON o.OrderID = oi.OrderID
JOIN Item i
    ON oi.ItemID = i.ItemID
ORDER BY o.OrderID;


-- TOTAL VALUE OF EACH ORDER
SELECT
    o.OrderID,
    o.OrderDate,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    r.RestaurantName,
    SUM(oi.Quantity * oi.UnitPrice) AS OrderTotal
FROM Orders o
JOIN Customer c
    ON o.CustomerID = c.CustomerID
JOIN Restaurant r
    ON o.RestaurantID = r.RestaurantID
JOIN Order_Item oi
    ON o.OrderID = oi.OrderID
GROUP BY
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName,
    r.RestaurantName
ORDER BY OrderTotal DESC;

-- RESTAURANT PERFORMANCE
SELECT
    r.RestaurantID,
    r.RestaurantName,
    COUNT(DISTINCT o.OrderID) AS NumberOfOrders,
    COALESCE(SUM(oi.Quantity * oi.UnitPrice), 0) AS TotalRevenue
FROM Restaurant r
LEFT JOIN Orders o
    ON r.RestaurantID = o.RestaurantID
LEFT JOIN Order_Item oi
    ON o.OrderID = oi.OrderID
GROUP BY
    r.RestaurantID,
    r.RestaurantName
ORDER BY TotalRevenue DESC;

-- DRIVER PERFORMANCE
SELECT
    d.DriverID,
    CONCAT(d.FirstName, ' ', d.LastName) AS DriverName,
    r.RestaurantName,
    COUNT(o.OrderID) AS OrdersDelivered,
    d.Salary
FROM Driver d
JOIN Restaurant r
    ON d.RestaurantID = r.RestaurantID
LEFT JOIN Orders o
    ON d.DriverID = o.DriverID
GROUP BY
    d.DriverID,
    d.FirstName,
    d.LastName,
    r.RestaurantName,
    d.Salary
ORDER BY OrdersDelivered DESC;

-- ITEM SALES ANALYSIS
SELECT
    i.ItemID,
    i.ItemName,
    c.CategoryName,
    SUM(oi.Quantity) AS QuantitySold,
    SUM(oi.Quantity * oi.UnitPrice) AS SalesRevenue
FROM Item i
JOIN Category c
    ON i.CategoryID = c.CategoryID
JOIN Order_Item oi
    ON i.ItemID = oi.ItemID
GROUP BY
    i.ItemID,
    i.ItemName,
    c.CategoryName
ORDER BY QuantitySold DESC;


-- CATEGORY PERFORMANCE
SELECT
    c.CategoryID,
    c.CategoryName,
    SUM(oi.Quantity) AS QuantitySold,
    SUM(oi.Quantity * oi.UnitPrice) AS CategoryRevenue
FROM Category c
JOIN Item i
    ON c.CategoryID = i.CategoryID
JOIN Order_Item oi
    ON i.ItemID = oi.ItemID
GROUP BY
    c.CategoryID,
    c.CategoryName
ORDER BY CategoryRevenue DESC;


-- RESTAURANT ITEM PRICES
SELECT
    r.RestaurantName,
    i.ItemName,
    c.CategoryName,
    ri.CurrentPrice
FROM Restaurant_Item ri
JOIN Restaurant r
    ON ri.RestaurantID = r.RestaurantID
JOIN Item i
    ON ri.ItemID = i.ItemID
JOIN Category c
    ON i.CategoryID = c.CategoryID
ORDER BY
    r.RestaurantName,
    i.ItemName;


-- COMPARE ITEM PRICES ACROSS RESTAURANTS
SELECT
    i.ItemName,
    MIN(ri.CurrentPrice) AS MinimumPrice,
    MAX(ri.CurrentPrice) AS MaximumPrice,
    ROUND(AVG(ri.CurrentPrice), 2) AS AveragePrice
FROM Item i
JOIN Restaurant_Item ri
    ON i.ItemID = ri.ItemID
GROUP BY
    i.ItemID,
    i.ItemName
ORDER BY i.ItemName;


-- DRIVER + MANAGER + RESTAURANT INFORMATION
SELECT
    d.DriverID,
    CONCAT(d.FirstName, ' ', d.LastName) AS DriverName,
    d.Salary,
    d.NIN_Number,
    CONCAT(m.FirstName, ' ', m.LastName) AS ManagerName,
    r.RestaurantName,
    mb.RegistrationNo,
    mb.Colour,
    mb.EngineSize,
    dl.LicenseNumber,
    dl.IssueDate,
    dl.CountryOfIssue,
    dl.ExpiryDate
FROM Driver d
JOIN Manager m
    ON d.ManagerID = m.ManagerID
JOIN Restaurant r
    ON d.RestaurantID = r.RestaurantID
JOIN Motorbike mb
    ON d.MotorbikeID = mb.MotorbikeID
JOIN Driving_License dl
    ON d.LicenseID = dl.LicenseID
ORDER BY d.DriverID;


-- TOTAL PAYROLL
SELECT
    COUNT(*) AS NumberOfDrivers,
    SUM(Salary) AS TotalMonthlyPayroll,
    ROUND(AVG(Salary), 2) AS AverageDriverSalary,
    MIN(Salary) AS MinimumSalary,
    MAX(Salary) AS MaximumSalary
FROM Driver;


-- MANAGER AND DRIVER ANALYSIS
SELECT
    m.ManagerID,
    CONCAT(m.FirstName, ' ', m.LastName) AS ManagerName,
    COUNT(d.DriverID) AS NumberOfDrivers
FROM Manager m
LEFT JOIN Driver d
    ON m.ManagerID = d.ManagerID
GROUP BY
    m.ManagerID,
    m.FirstName,
    m.LastName
ORDER BY NumberOfDrivers DESC;


-- DATABASE RELATIONSHIP VERIFICATION
SELECT
    d.DriverID,
    CONCAT(d.FirstName, ' ', d.LastName) AS DriverName,
    CONCAT(m.FirstName, ' ', m.LastName) AS ManagerName,
    r.RestaurantName,
    mb.RegistrationNo AS MotorbikeRegistration,
    dl.LicenseNumber
FROM Driver d
JOIN Manager m
    ON d.ManagerID = m.ManagerID
JOIN Restaurant r
    ON d.RestaurantID = r.RestaurantID
JOIN Motorbike mb
    ON d.MotorbikeID = mb.MotorbikeID
JOIN Driving_License dl
    ON d.LicenseID = dl.LicenseID;


-- TABLE STRUCTURE VERIFICATION
DESCRIBE Manager;

DESCRIBE Restaurant;

DESCRIBE Category;

DESCRIBE Customer;

DESCRIBE Motorbike;

DESCRIBE Driving_License;

DESCRIBE Item;

DESCRIBE Driver;

DESCRIBE Restaurant_Item;

DESCRIBE Orders;

DESCRIBE Order_Item;

SHOW CREATE TABLE Driver;

SHOW CREATE TABLE Restaurant_Item;

SHOW CREATE TABLE Orders;

SHOW CREATE TABLE Order_Item;

