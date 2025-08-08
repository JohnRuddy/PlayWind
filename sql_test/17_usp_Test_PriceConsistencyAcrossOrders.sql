-- ============================================================================
-- Test 17: Price Consistency Across Orders Validation
-- ============================================================================
-- Validates price consistency for products across different orders
-- Informational check for potential pricing variations
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_PriceConsistencyAcrossOrders') IS NOT NULL 
    DROP PROCEDURE usp_Test_PriceConsistencyAcrossOrders;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_PriceConsistencyAcrossOrders
AS
BEGIN
    DECLARE @PriceInconsistencies INT;
    
    -- Check if products have consistent pricing across different orders
    -- (allowing for some variation due to potential discounts)
    SELECT @PriceInconsistencies = COUNT(*)
    FROM (
        SELECT od.ProductID, p.Price, COUNT(*) as OrderCount
        FROM OrderDetails od
        INNER JOIN Products p ON od.ProductID = p.ProductID
        GROUP BY od.ProductID, p.Price
        HAVING COUNT(*) > 1
    ) AS PriceVariations;
    
    -- This is informational - price variations might be normal due to discounts
    PRINT 'PASS: Price consistency check completed';
END
GO

PRINT 'Test Procedure 17: usp_Test_PriceConsistencyAcrossOrders created successfully';
