-- ============================================================================
-- Test 20: Product Name Uniqueness Validation
-- ============================================================================
-- Validates that all product names are unique
-- Ensures no duplicate product names exist
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_ProductNameUniqueness') IS NOT NULL 
    DROP PROCEDURE usp_Test_ProductNameUniqueness;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_ProductNameUniqueness
AS
BEGIN
    DECLARE @DuplicateProductNames INT;
    
    -- Check for products with identical names
    SELECT @DuplicateProductNames = COUNT(*) - COUNT(DISTINCT ProductName)
    FROM Products
    WHERE ProductName IS NOT NULL;
    
    IF @DuplicateProductNames > 0
        THROW 50041, 'Found Products with duplicate names', 1;
    
    PRINT 'PASS: All product names are unique';
END
GO

PRINT 'Test Procedure 20: usp_Test_ProductNameUniqueness created successfully';
