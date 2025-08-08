-- ============================================================================
-- Test 15: Order Shipping Logic Validation
-- ============================================================================
-- Validates that all orders have proper shipper assignments
-- Ensures complete order shipping workflow
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_OrderShippingLogic') IS NOT NULL 
    DROP PROCEDURE usp_Test_OrderShippingLogic;
GO

-- Create the test procedure
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

PRINT 'Test Procedure 15: usp_Test_OrderShippingLogic created successfully';
