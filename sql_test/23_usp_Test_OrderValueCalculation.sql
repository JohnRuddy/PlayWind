-- ============================================================================
-- Test 23: Order Value Calculation Validation
-- ============================================================================
-- Validates that all orders have positive total values
-- Ensures proper order value calculations
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_OrderValueCalculation') IS NOT NULL 
    DROP PROCEDURE usp_Test_OrderValueCalculation;
GO

-- Create the test procedure
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

PRINT 'Test Procedure 23: usp_Test_OrderValueCalculation created successfully';
