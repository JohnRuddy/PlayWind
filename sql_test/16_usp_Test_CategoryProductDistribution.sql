-- ============================================================================
-- Test 16: Category Product Distribution Validation
-- ============================================================================
-- Validates balanced product distribution across categories
-- Checks for empty categories and overloaded categories
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_CategoryProductDistribution') IS NOT NULL 
    DROP PROCEDURE usp_Test_CategoryProductDistribution;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_CategoryProductDistribution
AS
BEGIN
    DECLARE @EmptyCategories INT, @OverloadedCategories INT;
    
    -- Check for categories with no products
    SELECT @EmptyCategories = COUNT(*)
    FROM Categories c
    LEFT JOIN Products p ON c.CategoryID = p.CategoryID
    WHERE p.CategoryID IS NULL;
    
    -- Check for categories with too many products (over 20)
    SELECT @OverloadedCategories = COUNT(*)
    FROM (
        SELECT c.CategoryID, COUNT(p.ProductID) as ProductCount
        FROM Categories c
        LEFT JOIN Products p ON c.CategoryID = p.CategoryID
        GROUP BY c.CategoryID
        HAVING COUNT(p.ProductID) > 20
    ) AS OverloadedCats;
    
    IF @EmptyCategories > 0
        THROW 50038, 'Found Categories without Products', 1;
        
    IF @OverloadedCategories > 0
        THROW 50039, 'Found Categories with excessive product count (>20)', 1;
    
    PRINT 'PASS: Category product distribution is balanced';
END
GO

PRINT 'Test Procedure 16: usp_Test_CategoryProductDistribution created successfully';
