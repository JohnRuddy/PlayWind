-- ============================================================================
-- Test 30: Null Value Validation
-- ============================================================================
-- Validates that critical business fields do not contain NULL values
-- Ensures data completeness in essential fields
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_NullValueValidation') IS NOT NULL 
    DROP PROCEDURE usp_Test_NullValueValidation;
GO

-- Create the test procedure
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

PRINT 'Test Procedure 30: usp_Test_NullValueValidation created successfully';
