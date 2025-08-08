-- ============================================================================
-- Test 2: Orphaned Orders Validation
-- ============================================================================
-- Validates that all Orders have valid Customer, Employee, and Shipper references
-- Checks for Orders with invalid foreign key references
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_OrphanedOrders') IS NOT NULL 
    DROP PROCEDURE usp_Test_OrphanedOrders;
GO

-- Create the test procedure
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

PRINT 'Test Procedure 02: usp_Test_OrphanedOrders created successfully';
