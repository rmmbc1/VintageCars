-- SELECT * FROM customers LIMIT 5;
-- SELECT * FROM employees LIMIT 5;
-- SELECT * FROM offices LIMIT 5;
-- SELECT * FROM orderdetails LIMIT 5;
-- SELECT * FROM orders LIMIT 5;
-- SELECT * FROM payments LIMIT 5;
-- SELECT * FROM productlines LIMIT 5;
-- SELECT * FROM products LIMIT 5;



SELECT
    -- Customers
    c.customerNumber,
    c.customerName,
    c.contactLastName,
    c.contactFirstName,
    c.phone AS customerPhone,
    c.addressLine1 AS customerAddress1,
    c.addressLine2 AS customerAddress2,
    c.city AS customerCity,
    c.state AS customerState,
    c.postalCode AS customerPostalCode,
    c.country AS customerCountry,
    c.creditLimit,
    
    -- Employees
    e.employeeNumber,
    e.lastName AS employeeLastName,
    e.firstName AS employeeFirstName,
    e.extension,
    e.email,
    e.officeCode,
    e.reportsTo,
    e.jobTitle,
    
    -- Offices
    o.officeCode,
    o.city AS officeCity,
    o.phone AS officePhone,
    o.addressLine1 AS officeAddress1,
    o.addressLine2 AS officeAddress2,
    o.state AS officeState,
    o.country AS officeCountry,
    o.postalCode AS officePostalCode,
    o.territory,
    
    -- Orders
    ord.orderNumber,
    ord.orderDate,
    ord.requiredDate,
    ord.shippedDate,
    ord.status AS orderStatus,
    ord.comments,
    
    -- OrderDetails
    od.productCode,
    od.quantityOrdered,
    od.priceEach,
    od.orderLineNumber,
    
    -- Products
    p.productName,
    p.productLine,
    p.productScale,
    p.productVendor,
    p.productDescription,
    p.quantityInStock,
    p.buyPrice,
    p.MSRP,
    -- New Brand Column
    CASE 
        WHEN SUBSTRING(`p`.`productName`, 1, 4) REGEXP '^[0-9]{4}$' THEN 
            TRIM(SUBSTRING_INDEX(SUBSTRING(`p`.`productName`, 6), ' ', 1))
        ELSE 
            NULL 
    END AS `brand`,
    
    
    -- ProductLines
    pl.textDescription,
    pl.htmlDescription,
    pl.image,
    
    -- Payments
    pay.checkNumber,
    pay.paymentDate,
    pay.amount AS paymentAmount
    
FROM customers c
LEFT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN offices o ON e.officeCode = o.officeCode
LEFT JOIN orders ord ON c.customerNumber = ord.customerNumber
LEFT JOIN orderdetails od ON ord.orderNumber = od.orderNumber
LEFT JOIN products p ON od.productCode = p.productCode
LEFT JOIN productlines pl ON p.productLine = pl.productLine
LEFT JOIN payments pay ON c.customerNumber = pay.customerNumber;

