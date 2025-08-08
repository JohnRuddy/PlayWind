-- ============================================================================
-- Test 24: Product Unit Validation
-- ============================================================================
-- Validates that all products have proper unit information
-- Ensures complete product specification data
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_ProductUnitValidation') IS NOT NULL 
    DROP PROCEDURE usp_Test_ProductUnitValidation;
GO

-- Create the test procedure
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

PRINT 'Test Procedure 24: usp_Test_ProductUnitValidation created successfully';
