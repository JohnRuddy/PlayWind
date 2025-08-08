-- ============================================================================
-- Test 12: Product Inventory Logic Validation
-- ============================================================================
-- Validates that all products have proper category and supplier assignments
-- Ensures complete product inventory management
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_ProductInventoryLogic') IS NOT NULL 
    DROP PROCEDURE usp_Test_ProductInventoryLogic;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_ProductInventoryLogic
AS
BEGIN
    DECLARE @ProductsWithoutCategories INT, @ProductsWithoutSuppliers INT;
    
    -- Products should have both category and supplier
    SELECT @ProductsWithoutCategories = COUNT(*)
    FROM Products WHERE CategoryID IS NULL;
    
    SELECT @ProductsWithoutSuppliers = COUNT(*)
    FROM Products WHERE SupplierID IS NULL;
    
    IF @ProductsWithoutCategories > 0
        THROW 50033, 'Found Products without Category assignment', 1;
        
    IF @ProductsWithoutSuppliers > 0
        THROW 50034, 'Found Products without Supplier assignment', 1;
    
    PRINT 'PASS: All products have proper category and supplier assignments';
END
GO

PRINT 'Test Procedure 12: usp_Test_ProductInventoryLogic created successfully';
