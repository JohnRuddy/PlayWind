-- ============================================================================
-- Test 14: Supplier Product Relationship Validation
-- ============================================================================
-- Validates that all suppliers have at least one product
-- Ensures active supplier-product relationships
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_SupplierProductRelationship') IS NOT NULL 
    DROP PROCEDURE usp_Test_SupplierProductRelationship;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_SupplierProductRelationship
AS
BEGIN
    DECLARE @SuppliersWithoutProducts INT;
    
    -- All suppliers should have at least one product
    SELECT @SuppliersWithoutProducts = COUNT(*)
    FROM Suppliers s
    LEFT JOIN Products p ON s.SupplierID = p.SupplierID
    WHERE p.SupplierID IS NULL;
    
    IF @SuppliersWithoutProducts > 0
        THROW 50036, 'Found Suppliers without any Products', 1;
    
    PRINT 'PASS: All suppliers have at least one product';
END
GO

PRINT 'Test Procedure 14: usp_Test_SupplierProductRelationship created successfully';
