-- ============================================================================
-- Test 4: Primary Key Integrity Validation
-- ============================================================================
-- Validates that all primary keys are unique across all tables
-- Checks for duplicate primary key values in all core tables
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_PrimaryKeyIntegrity') IS NOT NULL 
    DROP PROCEDURE usp_Test_PrimaryKeyIntegrity;
GO

-- Create the test procedure
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

PRINT 'Test Procedure 04: usp_Test_PrimaryKeyIntegrity created successfully';
