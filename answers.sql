-- Question 1
/* Creating new table to store normalized data.
 This table will have one product per row, which is required for 1NF.*/
CREATE TABLE ProductDetail_1NF (
    OrderID INT,               -- The ID of the order
    CustomerName VARCHAR(255), -- The name of the customer who placed the order
    Product VARCHAR(255)       -- A single product from the order
);

/* Insert data into the new table, splitting the "Products" column (which has multiple products in one row)
 into separate rows, so each row has only one product.*/
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Question 2
/* Creating new table for customer details.
 This table will store the unique relationship between OrderID and CustomerName.*/
CREATE TABLE CustomerDetails (
    OrderID INT PRIMARY KEY,       -- OrderID is the primary key for this table
    CustomerName VARCHAR(255)      -- CustomerName depends only on OrderID
);

/* Inserting unique OrderID and CustomerName pairs into the new table
 This removes the partial dependency of CustomerName on OrderID.*/
INSERT INTO CustomerDetails (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

/* Creating new table for order details.
 This table will store the relationship between OrderID, Product, and Quantity.*/
CREATE TABLE OrderDetails_2NF (
    OrderID INT,                   -- OrderID is a foreign key referencing CustomerDetails
    Product VARCHAR(255),          -- Product is part of the composite key
    Quantity INT,                  -- Quantity of the product
    PRIMARY KEY (OrderID, Product), -- Composite primary key ensures no duplicate rows
    FOREIGN KEY (OrderID) REFERENCES CustomerDetails(OrderID) -- Enforce referential integrity
);

/* Inserting data into the new OrderDetails_2NF table.
 This table now contains only the details that depend on both OrderID and Product.*/
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

/* Verify the results.
 Check the CustomerDetails table to ensure the data is correct.*/
SELECT * FROM CustomerDetails;

-- Check the OrderDetails_2NF table to ensure the data is normalized.
SELECT * FROM OrderDetails_2NF;
