-- ============================================================================
-- Test 26: Shipper Performance Data Validation
-- ============================================================================
-- Validates that all shippers have shipping history
-- Ensures active shipper participation in order fulfillment
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_ShipperPerformanceData') IS NOT NULL 
    DROP PROCEDURE usp_Test_ShipperPerformanceData;
GO

-- Create the test procedure
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

PRINT 'Test Procedure 26: usp_Test_ShipperPerformanceData created successfully';
