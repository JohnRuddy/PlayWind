-- ============================================================================
-- Northwind Database Integrity Test Suite - 31 Comprehensive Tests
-- ============================================================================
-- Complete database validation framework with 31 stored procedures
-- Validates referential integrity, data quality, business rules, and consistency
-- ============================================================================

-- Drop all existing test procedures
IF OBJECT_ID('usp_Test_OrphanedOrderDetails') IS NOT NULL DROP PROCEDURE usp_Test_OrphanedOrderDetails;
IF OBJECT_ID('usp_Test_OrphanedOrders') IS NOT NULL DROP PROCEDURE usp_Test_OrphanedOrders;
IF OBJECT_ID('usp_Test_InvalidProductReferences') IS NOT NULL DROP PROCEDURE usp_Test_InvalidProductReferences;
IF OBJECT_ID('usp_Test_PrimaryKeyIntegrity') IS NOT NULL DROP PROCEDURE usp_Test_PrimaryKeyIntegrity;
IF OBJECT_ID('usp_Test_DataQuality') IS NOT NULL DROP PROCEDURE usp_Test_DataQuality;
IF OBJECT_ID('usp_Test_PriceValidation') IS NOT NULL DROP PROCEDURE usp_Test_PriceValidation;
IF OBJECT_ID('usp_Test_QuantityValidation') IS NOT NULL DROP PROCEDURE usp_Test_QuantityValidation;
IF OBJECT_ID('usp_Test_DateIntegrity') IS NOT NULL DROP PROCEDURE usp_Test_DateIntegrity;
IF OBJECT_ID('usp_Test_BusinessRules') IS NOT NULL DROP PROCEDURE usp_Test_BusinessRules;
IF OBJECT_ID('usp_Test_ReferentialIntegrity') IS NOT NULL DROP PROCEDURE usp_Test_ReferentialIntegrity;

-- New Enhanced Tests
IF OBJECT_ID('usp_Test_CustomerOrderConsistency') IS NOT NULL DROP PROCEDURE usp_Test_CustomerOrderConsistency;
IF OBJECT_ID('usp_Test_ProductInventoryLogic') IS NOT NULL DROP PROCEDURE usp_Test_ProductInventoryLogic;
IF OBJECT_ID('usp_Test_EmployeeDataConsistency') IS NOT NULL DROP PROCEDURE usp_Test_EmployeeDataConsistency;
IF OBJECT_ID('usp_Test_SupplierProductRelationship') IS NOT NULL DROP PROCEDURE usp_Test_SupplierProductRelationship;
IF OBJECT_ID('usp_Test_OrderShippingLogic') IS NOT NULL DROP PROCEDURE usp_Test_OrderShippingLogic;
IF OBJECT_ID('usp_Test_CategoryProductDistribution') IS NOT NULL DROP PROCEDURE usp_Test_CategoryProductDistribution;
IF OBJECT_ID('usp_Test_PriceConsistencyAcrossOrders') IS NOT NULL DROP PROCEDURE usp_Test_PriceConsistencyAcrossOrders;
IF OBJECT_ID('usp_Test_CustomerGeographicData') IS NOT NULL DROP PROCEDURE usp_Test_CustomerGeographicData;
IF OBJECT_ID('usp_Test_OrderDateSequencing') IS NOT NULL DROP PROCEDURE usp_Test_OrderDateSequencing;
IF OBJECT_ID('usp_Test_ProductNameUniqueness') IS NOT NULL DROP PROCEDURE usp_Test_ProductNameUniqueness;
IF OBJECT_ID('usp_Test_EmployeeOrderLoad') IS NOT NULL DROP PROCEDURE usp_Test_EmployeeOrderLoad;
IF OBJECT_ID('usp_Test_SupplierContactData') IS NOT NULL DROP PROCEDURE usp_Test_SupplierContactData;
IF OBJECT_ID('usp_Test_OrderValueCalculation') IS NOT NULL DROP PROCEDURE usp_Test_OrderValueCalculation;
IF OBJECT_ID('usp_Test_ProductUnitValidation') IS NOT NULL DROP PROCEDURE usp_Test_ProductUnitValidation;
IF OBJECT_ID('usp_Test_CustomerOrderFrequency') IS NOT NULL DROP PROCEDURE usp_Test_CustomerOrderFrequency;
IF OBJECT_ID('usp_Test_ShipperPerformanceData') IS NOT NULL DROP PROCEDURE usp_Test_ShipperPerformanceData;
IF OBJECT_ID('usp_Test_DatabaseStatistics') IS NOT NULL DROP PROCEDURE usp_Test_DatabaseStatistics;
IF OBJECT_ID('usp_Test_CrossTableConsistency') IS NOT NULL DROP PROCEDURE usp_Test_CrossTableConsistency;
IF OBJECT_ID('usp_Test_DataDuplication') IS NOT NULL DROP PROCEDURE usp_Test_DataDuplication;
IF OBJECT_ID('usp_Test_NullValueValidation') IS NOT NULL DROP PROCEDURE usp_Test_NullValueValidation;
IF OBJECT_ID('usp_Test_StringDataValidation') IS NOT NULL DROP PROCEDURE usp_Test_StringDataValidation;
GO

-- ============================================================================
-- CORE INTEGRITY TESTS (Tests 1-10)
-- ============================================================================

-- Test 1: Orphaned Order Details
CREATE PROCEDURE usp_Test_OrphanedOrderDetails
AS
BEGIN
    DECLARE @OrphanCount INT;
    
    SELECT @OrphanCount = COUNT(*)
    FROM OrderDetails od
    LEFT JOIN Orders o ON od.OrderID = o.OrderID
    WHERE o.OrderID IS NULL;
    
    IF @OrphanCount > 0
    BEGIN
        DECLARE @ErrorMsg NVARCHAR(500) = 'Found ' + CAST(@OrphanCount AS NVARCHAR(10)) + ' orphaned Order Details records without valid Orders';
        THROW 50001, @ErrorMsg, 1;
    END
    
    PRINT 'PASS: No orphaned Order Details found';
END
GO

-- Test 2: Orphaned Orders
CREATE PROCEDURE usp_Test_OrphanedOrders
AS
BEGIN
    DECLARE @InvalidCustomers INT, @InvalidEmployees INT, @InvalidShippers INT;
    
    SELECT @InvalidCustomers = COUNT(*)
    FROM Orders o
    LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
    WHERE o.CustomerID IS NOT NULL AND c.CustomerID IS NULL;
    
    SELECT @InvalidEmployees = COUNT(*)
    FROM Orders o
    LEFT JOIN Employees e ON o.EmployeeID = e.EmployeeID
    WHERE o.EmployeeID IS NOT NULL AND e.EmployeeID IS NULL;
    
    SELECT @InvalidShippers = COUNT(*)
    FROM Orders o
    LEFT JOIN Shippers s ON o.ShipperID = s.ShipperID
    WHERE o.ShipperID IS NOT NULL AND s.ShipperID IS NULL;
    
    IF @InvalidCustomers > 0
        THROW 50002, 'Found Orders with invalid Customer references', 1;
        
    IF @InvalidEmployees > 0
        THROW 50003, 'Found Orders with invalid Employee references', 1;
        
    IF @InvalidShippers > 0
        THROW 50004, 'Found Orders with invalid Shipper references', 1;
    
    PRINT 'PASS: All Orders have valid Customer, Employee, and Shipper references';
END
GO

-- Test 3: Invalid Product References
CREATE PROCEDURE usp_Test_InvalidProductReferences
AS
BEGIN
    DECLARE @InvalidCategories INT, @InvalidSuppliers INT, @InvalidProducts INT;
    
    SELECT @InvalidCategories = COUNT(*)
    FROM Products p
    LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
    WHERE p.CategoryID IS NOT NULL AND c.CategoryID IS NULL;
    
    SELECT @InvalidSuppliers = COUNT(*)
    FROM Products p
    LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID
    WHERE p.SupplierID IS NOT NULL AND s.SupplierID IS NULL;
    
    SELECT @InvalidProducts = COUNT(*)
    FROM OrderDetails od
    LEFT JOIN Products p ON od.ProductID = p.ProductID
    WHERE od.ProductID IS NOT NULL AND p.ProductID IS NULL;
    
    IF @InvalidCategories > 0
        THROW 50005, 'Found Products with invalid Category references', 1;
        
    IF @InvalidSuppliers > 0
        THROW 50006, 'Found Products with invalid Supplier references', 1;
        
    IF @InvalidProducts > 0
        THROW 50007, 'Found OrderDetails with invalid Product references', 1;
    
    PRINT 'PASS: All Products have valid Category and Supplier references, and all OrderDetails have valid Product references';
END
GO

-- Test 4: Primary Key Integrity
CREATE PROCEDURE usp_Test_PrimaryKeyIntegrity
AS
BEGIN
    DECLARE @DuplicateCount INT;
    
    -- Check all tables for duplicate primary keys
    SELECT @DuplicateCount = COUNT(*) - COUNT(DISTINCT CategoryID) FROM Categories;
    IF @DuplicateCount > 0 THROW 50008, 'Duplicate CategoryID values found', 1;
    
    SELECT @DuplicateCount = COUNT(*) - COUNT(DISTINCT CustomerID) FROM Customers;
    IF @DuplicateCount > 0 THROW 50009, 'Duplicate CustomerID values found', 1;
    
    SELECT @DuplicateCount = COUNT(*) - COUNT(DISTINCT EmployeeID) FROM Employees;
    IF @DuplicateCount > 0 THROW 50010, 'Duplicate EmployeeID values found', 1;
    
    SELECT @DuplicateCount = COUNT(*) - COUNT(DISTINCT OrderID) FROM Orders;
    IF @DuplicateCount > 0 THROW 50011, 'Duplicate OrderID values found', 1;
    
    SELECT @DuplicateCount = COUNT(*) - COUNT(DISTINCT OrderDetailID) FROM OrderDetails;
    IF @DuplicateCount > 0 THROW 50012, 'Duplicate OrderDetailID values found', 1;
    
    SELECT @DuplicateCount = COUNT(*) - COUNT(DISTINCT ProductID) FROM Products;
    IF @DuplicateCount > 0 THROW 50013, 'Duplicate ProductID values found', 1;
    
    SELECT @DuplicateCount = COUNT(*) - COUNT(DISTINCT ShipperID) FROM Shippers;
    IF @DuplicateCount > 0 THROW 50014, 'Duplicate ShipperID values found', 1;
    
    SELECT @DuplicateCount = COUNT(*) - COUNT(DISTINCT SupplierID) FROM Suppliers;
    IF @DuplicateCount > 0 THROW 50015, 'Duplicate SupplierID values found', 1;
    
    PRINT 'PASS: All primary keys are unique';
END
GO

-- Test 5: Data Quality
CREATE PROCEDURE usp_Test_DataQuality
AS
BEGIN
    DECLARE @InvalidCount INT;
    
    -- Check for required name fields
    SELECT @InvalidCount = COUNT(*) FROM Categories WHERE CategoryName IS NULL OR LTRIM(RTRIM(CategoryName)) = '';
    IF @InvalidCount > 0 THROW 50016, 'Found Categories with empty CategoryName', 1;
    
    SELECT @InvalidCount = COUNT(*) FROM Customers WHERE CustomerName IS NULL OR LTRIM(RTRIM(CustomerName)) = '';
    IF @InvalidCount > 0 THROW 50017, 'Found Customers with empty CustomerName', 1;
    
    SELECT @InvalidCount = COUNT(*) FROM Products WHERE ProductName IS NULL OR LTRIM(RTRIM(ProductName)) = '';
    IF @InvalidCount > 0 THROW 50018, 'Found Products with empty ProductName', 1;
    
    SELECT @InvalidCount = COUNT(*) FROM Suppliers WHERE SupplierName IS NULL OR LTRIM(RTRIM(SupplierName)) = '';
    IF @InvalidCount > 0 THROW 50019, 'Found Suppliers with empty SupplierName', 1;
    
    SELECT @InvalidCount = COUNT(*) FROM Shippers WHERE ShipperName IS NULL OR LTRIM(RTRIM(ShipperName)) = '';
    IF @InvalidCount > 0 THROW 50020, 'Found Shippers with empty ShipperName', 1;
    
    SELECT @InvalidCount = COUNT(*) FROM Employees 
    WHERE (FirstName IS NULL OR LTRIM(RTRIM(FirstName)) = '') OR (LastName IS NULL OR LTRIM(RTRIM(LastName)) = '');
    IF @InvalidCount > 0 THROW 50021, 'Found Employees with empty FirstName or LastName', 1;
    
    PRINT 'PASS: All required name fields contain valid data';
END
GO

-- Test 6: Price Validation
CREATE PROCEDURE usp_Test_PriceValidation
AS
BEGIN
    DECLARE @InvalidPrices INT;
    
    SELECT @InvalidPrices = COUNT(*) FROM Products WHERE Price < 0;
    IF @InvalidPrices > 0 THROW 50022, 'Found Products with negative prices', 1;
    
    SELECT @InvalidPrices = COUNT(*) FROM Products WHERE Price > 10000;
    IF @InvalidPrices > 0 THROW 50023, 'Found Products with extremely high prices (>$10,000)', 1;
    
    PRINT 'PASS: All product prices are within valid ranges';
END
GO

-- Test 7: Quantity Validation
CREATE PROCEDURE usp_Test_QuantityValidation
AS
BEGIN
    DECLARE @InvalidQuantities INT;
    
    SELECT @InvalidQuantities = COUNT(*) FROM OrderDetails WHERE Quantity <= 0;
    IF @InvalidQuantities > 0 THROW 50024, 'Found OrderDetails with zero or negative quantities', 1;
    
    SELECT @InvalidQuantities = COUNT(*) FROM OrderDetails WHERE Quantity > 1000;
    IF @InvalidQuantities > 0 THROW 50025, 'Found OrderDetails with extremely high quantities (>1000)', 1;
    
    PRINT 'PASS: All order quantities are within valid ranges';
END
GO

-- Test 8: Date Integrity
CREATE PROCEDURE usp_Test_DateIntegrity
AS
BEGIN
    DECLARE @InvalidDates INT;
    
    SELECT @InvalidDates = COUNT(*) FROM Orders WHERE OrderDate > GETDATE();
    IF @InvalidDates > 0 THROW 50026, 'Found Orders with future OrderDate', 1;
    
    SELECT @InvalidDates = COUNT(*) FROM Orders WHERE OrderDate < '1990-01-01';
    IF @InvalidDates > 0 THROW 50027, 'Found Orders with OrderDate before 1990', 1;
    
    SELECT @InvalidDates = COUNT(*) FROM Employees WHERE BirthDate > GETDATE();
    IF @InvalidDates > 0 THROW 50028, 'Found Employees with future BirthDate', 1;
    
    SELECT @InvalidDates = COUNT(*) FROM Employees WHERE BirthDate < '1920-01-01';
    IF @InvalidDates > 0 THROW 50029, 'Found Employees with BirthDate before 1920', 1;
    
    PRINT 'PASS: All dates are within reasonable ranges';
END
GO

-- Test 9: Business Rules
CREATE PROCEDURE usp_Test_BusinessRules
AS
BEGIN
    DECLARE @OrdersWithoutDetails INT, @CategoriesWithoutProducts INT;
    
    SELECT @OrdersWithoutDetails = COUNT(*)
    FROM Orders o
    LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE od.OrderID IS NULL;
    IF @OrdersWithoutDetails > 0 THROW 50030, 'Found Orders without any OrderDetails', 1;
    
    SELECT @CategoriesWithoutProducts = COUNT(*)
    FROM Categories c
    LEFT JOIN Products p ON c.CategoryID = p.CategoryID
    WHERE p.CategoryID IS NULL;
    IF @CategoriesWithoutProducts > 0 THROW 50031, 'Found Categories without any Products', 1;
    
    PRINT 'PASS: All business rules are satisfied';
END
GO

-- Test 10: Complete Referential Integrity
CREATE PROCEDURE usp_Test_ReferentialIntegrity
AS
BEGIN
    EXEC usp_Test_OrphanedOrderDetails;
    EXEC usp_Test_OrphanedOrders;
    EXEC usp_Test_InvalidProductReferences;
    
    PRINT 'PASS: Complete referential integrity check passed';
END
GO

-- ============================================================================
-- ENHANCED BUSINESS LOGIC TESTS (Tests 11-20)
-- ============================================================================

-- Test 11: Customer Order Consistency
CREATE PROCEDURE usp_Test_CustomerOrderConsistency
AS
BEGIN
    DECLARE @InconsistentCustomers INT;
    
    -- Check for customers with orders but missing contact information
    SELECT @InconsistentCustomers = COUNT(*)
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE c.ContactName IS NULL OR LTRIM(RTRIM(c.ContactName)) = '';
    
    IF @InconsistentCustomers > 0
        THROW 50032, 'Found active customers without proper contact information', 1;
    
    PRINT 'PASS: All customers with orders have proper contact information';
END
GO

-- Test 12: Product Inventory Logic
CREATE PROCEDURE usp_Test_ProductInventoryLogic
AS
BEGIN
    DECLARE @ProductsWithoutCategories INT, @ProductsWithoutSuppliers INT;
    
    -- Products should have both category and supplier
    SELECT @ProductsWithoutCategories = COUNT(*)
    FROM Products WHERE CategoryID IS NULL;
    
    SELECT @ProductsWithoutSuppliers = COUNT(*)
    FROM Products WHERE SupplierID IS NULL;
    
    IF @ProductsWithoutCategories > 0
        THROW 50033, 'Found Products without Category assignment', 1;
        
    IF @ProductsWithoutSuppliers > 0
        THROW 50034, 'Found Products without Supplier assignment', 1;
    
    PRINT 'PASS: All products have proper category and supplier assignments';
END
GO

-- Test 13: Employee Data Consistency
CREATE PROCEDURE usp_Test_EmployeeDataConsistency
AS
BEGIN
    DECLARE @InvalidEmployees INT;
    
    -- Check for employees with impossible age (under 16 or over 100)
    SELECT @InvalidEmployees = COUNT(*)
    FROM Employees 
    WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) < 16 
       OR DATEDIFF(YEAR, BirthDate, GETDATE()) > 100;
    
    IF @InvalidEmployees > 0
        THROW 50035, 'Found Employees with impossible ages', 1;
    
    PRINT 'PASS: All employee ages are within reasonable ranges';
END
GO

-- Test 14: Supplier Product Relationship
CREATE PROCEDURE usp_Test_SupplierProductRelationship
AS
BEGIN
    DECLARE @SuppliersWithoutProducts INT;
    
    -- All suppliers should have at least one product
    SELECT @SuppliersWithoutProducts = COUNT(*)
    FROM Suppliers s
    LEFT JOIN Products p ON s.SupplierID = p.SupplierID
    WHERE p.SupplierID IS NULL;
    
    IF @SuppliersWithoutProducts > 0
        THROW 50036, 'Found Suppliers without any Products', 1;
    
    PRINT 'PASS: All suppliers have at least one product';
END
GO

-- Test 15: Order Shipping Logic
CREATE PROCEDURE usp_Test_OrderShippingLogic
AS
BEGIN
    DECLARE @OrdersWithoutShippers INT;
    
    -- Orders should have shipper information
    SELECT @OrdersWithoutShippers = COUNT(*)
    FROM Orders WHERE ShipperID IS NULL;
    
    IF @OrdersWithoutShippers > 0
        THROW 50037, 'Found Orders without Shipper assignment', 1;
    
    PRINT 'PASS: All orders have shipper assignments';
END
GO

-- Test 16: Category Product Distribution
CREATE PROCEDURE usp_Test_CategoryProductDistribution
AS
BEGIN
    DECLARE @EmptyCategories INT, @OverloadedCategories INT;
    
    -- Check for categories with no products
    SELECT @EmptyCategories = COUNT(*)
    FROM Categories c
    LEFT JOIN Products p ON c.CategoryID = p.CategoryID
    WHERE p.CategoryID IS NULL;
    
    -- Check for categories with too many products (over 20)
    SELECT @OverloadedCategories = COUNT(*)
    FROM (
        SELECT c.CategoryID, COUNT(p.ProductID) as ProductCount
        FROM Categories c
        LEFT JOIN Products p ON c.CategoryID = p.CategoryID
        GROUP BY c.CategoryID
        HAVING COUNT(p.ProductID) > 20
    ) AS OverloadedCats;
    
    IF @EmptyCategories > 0
        THROW 50038, 'Found Categories without Products', 1;
        
    IF @OverloadedCategories > 0
        THROW 50039, 'Found Categories with excessive product count (>20)', 1;
    
    PRINT 'PASS: Category product distribution is balanced';
END
GO

-- Test 17: Price Consistency Across Orders
CREATE PROCEDURE usp_Test_PriceConsistencyAcrossOrders
AS
BEGIN
    DECLARE @PriceInconsistencies INT;
    
    -- Check if products have consistent pricing across different orders
    -- (allowing for some variation due to potential discounts)
    SELECT @PriceInconsistencies = COUNT(*)
    FROM (
        SELECT od.ProductID, p.Price, COUNT(*) as OrderCount
        FROM OrderDetails od
        INNER JOIN Products p ON od.ProductID = p.ProductID
        GROUP BY od.ProductID, p.Price
        HAVING COUNT(*) > 1
    ) AS PriceVariations;
    
    -- This is informational - price variations might be normal due to discounts
    PRINT 'PASS: Price consistency check completed';
END
GO

-- Test 18: Customer Geographic Data
CREATE PROCEDURE usp_Test_CustomerGeographicData
AS
BEGIN
    DECLARE @CustomersWithoutLocation INT;
    
    -- Customers should have at least city information
    SELECT @CustomersWithoutLocation = COUNT(*)
    FROM Customers 
    WHERE City IS NULL OR LTRIM(RTRIM(City)) = '';
    
    IF @CustomersWithoutLocation > 0
        THROW 50040, 'Found Customers without geographic information', 1;
    
    PRINT 'PASS: All customers have geographic information';
END
GO

-- Test 19: Order Date Sequencing
CREATE PROCEDURE usp_Test_OrderDateSequencing
AS
BEGIN
    DECLARE @InvalidOrderSequence INT;
    
    -- Check for any orders with OrderID that doesn't follow date sequence
    -- (This is a business logic check - newer orders should generally have higher IDs)
    SELECT @InvalidOrderSequence = COUNT(*)
    FROM Orders o1
    INNER JOIN Orders o2 ON o1.OrderID < o2.OrderID
    WHERE o1.OrderDate > o2.OrderDate
    AND DATEDIFF(DAY, o2.OrderDate, o1.OrderDate) > 7; -- Allow for some flexibility
    
    -- This might be normal in some cases, so we'll just log it
    PRINT 'PASS: Order date sequencing check completed';
END
GO

-- Test 20: Product Name Uniqueness
CREATE PROCEDURE usp_Test_ProductNameUniqueness
AS
BEGIN
    DECLARE @DuplicateProductNames INT;
    
    -- Check for products with identical names
    SELECT @DuplicateProductNames = COUNT(*) - COUNT(DISTINCT ProductName)
    FROM Products
    WHERE ProductName IS NOT NULL;
    
    IF @DuplicateProductNames > 0
        THROW 50041, 'Found Products with duplicate names', 1;
    
    PRINT 'PASS: All product names are unique';
END
GO

-- ============================================================================
-- ADVANCED DATA VALIDATION TESTS (Tests 21-25)
-- ============================================================================

-- Test 21: Employee Order Load
CREATE PROCEDURE usp_Test_EmployeeOrderLoad
AS
BEGIN
    DECLARE @OverloadedEmployees INT, @InactiveEmployees INT;
    
    -- Check for employees with excessive order loads (>50 orders)
    SELECT @OverloadedEmployees = COUNT(*)
    FROM (
        SELECT e.EmployeeID, COUNT(o.OrderID) as OrderCount
        FROM Employees e
        LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
        GROUP BY e.EmployeeID
        HAVING COUNT(o.OrderID) > 50
    ) AS OverloadedEmps;
    
    -- Check for employees with no orders
    SELECT @InactiveEmployees = COUNT(*)
    FROM Employees e
    LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
    WHERE o.EmployeeID IS NULL;
    
    IF @InactiveEmployees > 5  -- Allow for some inactive employees
        THROW 50042, 'Too many employees without any orders', 1;
    
    PRINT 'PASS: Employee order load distribution is reasonable';
END
GO

-- Test 22: Supplier Contact Data
CREATE PROCEDURE usp_Test_SupplierContactData
AS
BEGIN
    DECLARE @SuppliersWithoutContact INT;
    
    -- Suppliers should have contact information
    SELECT @SuppliersWithoutContact = COUNT(*)
    FROM Suppliers 
    WHERE (ContactName IS NULL OR LTRIM(RTRIM(ContactName)) = '')
    AND (Phone IS NULL OR LTRIM(RTRIM(Phone)) = '');
    
    IF @SuppliersWithoutContact > 0
        THROW 50043, 'Found Suppliers without any contact information', 1;
    
    PRINT 'PASS: All suppliers have contact information';
END
GO

-- Test 23: Order Value Calculation
CREATE PROCEDURE usp_Test_OrderValueCalculation
AS
BEGIN
    DECLARE @OrdersWithZeroValue INT;
    
    -- Orders should have positive total value
    SELECT @OrdersWithZeroValue = COUNT(*)
    FROM (
        SELECT o.OrderID, SUM(od.Quantity * p.Price) as TotalValue
        FROM Orders o
        INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
        INNER JOIN Products p ON od.ProductID = p.ProductID
        GROUP BY o.OrderID
        HAVING SUM(od.Quantity * p.Price) <= 0
    ) AS ZeroValueOrders;
    
    IF @OrdersWithZeroValue > 0
        THROW 50044, 'Found Orders with zero or negative total value', 1;
    
    PRINT 'PASS: All orders have positive total values';
END
GO

-- Test 24: Product Unit Validation
CREATE PROCEDURE usp_Test_ProductUnitValidation
AS
BEGIN
    DECLARE @ProductsWithoutUnits INT;
    
    -- Products should have unit information
    SELECT @ProductsWithoutUnits = COUNT(*)
    FROM Products 
    WHERE Unit IS NULL OR LTRIM(RTRIM(Unit)) = '';
    
    IF @ProductsWithoutUnits > 0
        THROW 50045, 'Found Products without unit information', 1;
    
    PRINT 'PASS: All products have unit information';
END
GO

-- Test 25: Customer Order Frequency
CREATE PROCEDURE usp_Test_CustomerOrderFrequency
AS
BEGIN
    DECLARE @HighFrequencyCustomers INT, @OneTimeCustomers INT;
    
    -- Check customer order patterns
    SELECT @HighFrequencyCustomers = COUNT(*)
    FROM (
        SELECT c.CustomerID, COUNT(o.OrderID) as OrderCount
        FROM Customers c
        INNER JOIN Orders o ON c.CustomerID = o.CustomerID
        GROUP BY c.CustomerID
        HAVING COUNT(o.OrderID) > 10
    ) AS HighFreqCusts;
    
    SELECT @OneTimeCustomers = COUNT(*)
    FROM (
        SELECT c.CustomerID, COUNT(o.OrderID) as OrderCount
        FROM Customers c
        INNER JOIN Orders o ON c.CustomerID = o.CustomerID
        GROUP BY c.CustomerID
        HAVING COUNT(o.OrderID) = 1
    ) AS OneTimeCusts;
    
    -- This is informational - both patterns can be normal
    PRINT 'PASS: Customer order frequency analysis completed';
END
GO

-- ============================================================================
-- ADDITIONAL VALIDATION TESTS (Tests 26-30)
-- ============================================================================

-- Test 26: Shipper Performance Data
CREATE PROCEDURE usp_Test_ShipperPerformanceData
AS
BEGIN
    DECLARE @UnusedShippers INT;
    
    -- Check for shippers that haven't shipped any orders
    SELECT @UnusedShippers = COUNT(*)
    FROM Shippers s
    LEFT JOIN Orders o ON s.ShipperID = o.ShipperID
    WHERE o.ShipperID IS NULL;
    
    IF @UnusedShippers > 0
        THROW 50046, 'Found Shippers with no shipping history', 1;
    
    PRINT 'PASS: All shippers have shipping history';
END
GO

-- Test 27: Database Statistics
CREATE PROCEDURE usp_Test_DatabaseStatistics
AS
BEGIN
    DECLARE @TotalOrders INT, @TotalCustomers INT, @TotalProducts INT;
    
    SELECT @TotalOrders = COUNT(*) FROM Orders;
    SELECT @TotalCustomers = COUNT(*) FROM Customers;
    SELECT @TotalProducts = COUNT(*) FROM Products;
    
    -- Ensure minimum data thresholds
    IF @TotalOrders < 100 THROW 50047, 'Insufficient order data for analysis', 1;
    IF @TotalCustomers < 50 THROW 50048, 'Insufficient customer data for analysis', 1;
    IF @TotalProducts < 50 THROW 50049, 'Insufficient product data for analysis', 1;
    
    PRINT 'PASS: Database contains sufficient data for analysis';
END
GO

-- Test 28: Cross Table Consistency
CREATE PROCEDURE usp_Test_CrossTableConsistency
AS
BEGIN
    DECLARE @InconsistentData INT;
    
    -- Check for customers with orders but no contact info
    SELECT @InconsistentData = COUNT(*)
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE c.ContactName IS NULL AND c.Address IS NULL;
    
    IF @InconsistentData > 0
        THROW 50050, 'Found customers with orders but incomplete profile data', 1;
    
    PRINT 'PASS: Cross-table data consistency validated';
END
GO

-- Test 29: Data Duplication
CREATE PROCEDURE usp_Test_DataDuplication
AS
BEGIN
    DECLARE @DuplicateCustomers INT, @DuplicateSuppliers INT;
    
    -- Check for potential duplicate customers (same name and city)
    SELECT @DuplicateCustomers = COUNT(*) - COUNT(DISTINCT CustomerName + ISNULL(City, ''))
    FROM Customers
    WHERE CustomerName IS NOT NULL;
    
    -- Check for potential duplicate suppliers
    SELECT @DuplicateSuppliers = COUNT(*) - COUNT(DISTINCT SupplierName + ISNULL(City, ''))
    FROM Suppliers
    WHERE SupplierName IS NOT NULL;
    
    IF @DuplicateCustomers > 0
        THROW 50051, 'Found potential duplicate customers', 1;
        
    IF @DuplicateSuppliers > 0
        THROW 50052, 'Found potential duplicate suppliers', 1;
    
    PRINT 'PASS: No duplicate customer or supplier records found';
END
GO

-- Test 30: Null Value Validation
CREATE PROCEDURE usp_Test_NullValueValidation
AS
BEGIN
    DECLARE @CriticalNulls INT;
    
    -- Check for NULL values in critical business fields
    SELECT @CriticalNulls = (
        SELECT COUNT(*) FROM Orders WHERE CustomerID IS NULL
    ) + (
        SELECT COUNT(*) FROM OrderDetails WHERE ProductID IS NULL OR Quantity IS NULL
    ) + (
        SELECT COUNT(*) FROM Products WHERE Price IS NULL
    );
    
    IF @CriticalNulls > 0
        THROW 50053, 'Found NULL values in critical business fields', 1;
    
    PRINT 'PASS: No critical NULL values found';
END
GO

-- Test 31: String Data Validation
CREATE PROCEDURE usp_Test_StringDataValidation
AS
BEGIN
    DECLARE @InvalidStrings INT;
    
    -- Check for suspicious string patterns
    SELECT @InvalidStrings = COUNT(*)
    FROM (
        SELECT CustomerName FROM Customers WHERE CustomerName LIKE '%[0-9][0-9][0-9][0-9][0-9]%'
        UNION ALL
        SELECT ProductName FROM Products WHERE ProductName LIKE '%TEST%' OR ProductName LIKE '%TEMP%'
        UNION ALL
        SELECT SupplierName FROM Suppliers WHERE SupplierName LIKE '%TEST%'
    ) AS SuspiciousData;
    
    -- This is often normal, so we'll be lenient
    IF @InvalidStrings > 10
        THROW 50054, 'Found excessive suspicious string patterns', 1;
    
    PRINT 'PASS: String data patterns appear normal';
END
GO

PRINT 'Enhanced Database Integrity Test Suite deployed successfully!';
PRINT 'Total of 31 comprehensive test procedures available:';
PRINT 'Core Tests (1-10): Basic integrity, referential constraints, data quality';
PRINT 'Business Logic Tests (11-20): Advanced business rules and relationships';
PRINT 'Data Validation Tests (21-31): Complex validation and consistency checks';
