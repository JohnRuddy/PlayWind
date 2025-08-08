-- ============================================================================
-- Test 27: Database Statistics Thresholds Validation
-- ============================================================================
-- Validates that database contains sufficient data for meaningful analysis
-- Ensures minimum data thresholds are met
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_DatabaseStatistics') IS NOT NULL 
    DROP PROCEDURE usp_Test_DatabaseStatistics;
GO

-- Create the test procedure
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

PRINT 'Test Procedure 27: usp_Test_DatabaseStatistics created successfully';
