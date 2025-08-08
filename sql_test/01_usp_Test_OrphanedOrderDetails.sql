-- ============================================================================
-- Test 1: Orphaned Order Details Validation
-- ============================================================================
-- Validates that all OrderDetails have corresponding valid Orders
-- Checks for orphaned OrderDetails records without valid Order references
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_OrphanedOrderDetails') IS NOT NULL 
    DROP PROCEDURE usp_Test_OrphanedOrderDetails;
GO

-- Create the test procedure
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

PRINT 'Test Procedure 01: usp_Test_OrphanedOrderDetails created successfully';
