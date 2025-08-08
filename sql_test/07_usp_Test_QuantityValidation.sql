-- ============================================================================
-- Test 7: Quantity Validation
-- ============================================================================
-- Validates that all order quantities are within reasonable ranges
-- Checks for zero, negative, or extremely high quantities
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_QuantityValidation') IS NOT NULL 
    DROP PROCEDURE usp_Test_QuantityValidation;
GO

-- Create the test procedure
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

PRINT 'Test Procedure 07: usp_Test_QuantityValidation created successfully';
