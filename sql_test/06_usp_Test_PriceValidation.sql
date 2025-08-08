-- ============================================================================
-- Test 6: Price Validation
-- ============================================================================
-- Validates that all product prices are within reasonable ranges
-- Checks for negative prices and extremely high prices
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_PriceValidation') IS NOT NULL 
    DROP PROCEDURE usp_Test_PriceValidation;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_PriceValidation
AS
BEGIN
    DECLARE @InvalidPrices INT;
    
    SELECT @InvalidPrices = COUNT(*) FROM Products WHERE Price < 0;
    IF @InvalidPrices > 0 THROW 50022, 'Found Products with negative prices', 1;
    
    SELECT @InvalidPrices = COUNT(*) FROM Products WHERE Price > 10000;
    IF @InvalidPrices > 0 THROW 50023, 'Found Products with extremely high prices (>$10,000)', 1;
    
    PRINT 'PASS: All product prices are within valid ranges';
END
GO

PRINT 'Test Procedure 06: usp_Test_PriceValidation created successfully';
