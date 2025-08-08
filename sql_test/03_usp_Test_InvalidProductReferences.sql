-- ============================================================================
-- Test 3: Invalid Product References Validation
-- ============================================================================
-- Validates that all Products have valid Category and Supplier references
-- Validates that all OrderDetails have valid Product references
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_InvalidProductReferences') IS NOT NULL 
    DROP PROCEDURE usp_Test_InvalidProductReferences;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_InvalidProductReferences
AS
BEGIN
    DECLARE @InvalidCategories INT, @InvalidSuppliers INT, @InvalidProducts INT;
    
    SELECT @InvalidCategories = COUNT(*)
    FROM Products p
    LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
    WHERE p.CategoryID IS NOT NULL AND c.CategoryID IS NULL;
    
    SELECT @InvalidSuppliers = COUNT(*)
    FROM Products p
    LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID
    WHERE p.SupplierID IS NOT NULL AND s.SupplierID IS NULL;
    
    SELECT @InvalidProducts = COUNT(*)
    FROM OrderDetails od
    LEFT JOIN Products p ON od.ProductID = p.ProductID
    WHERE od.ProductID IS NOT NULL AND p.ProductID IS NULL;
    
    IF @InvalidCategories > 0
        THROW 50005, 'Found Products with invalid Category references', 1;
        
    IF @InvalidSuppliers > 0
        THROW 50006, 'Found Products with invalid Supplier references', 1;
        
    IF @InvalidProducts > 0
        THROW 50007, 'Found OrderDetails with invalid Product references', 1;
    
    PRINT 'PASS: All Products have valid Category and Supplier references, and all OrderDetails have valid Product references';
END
GO

PRINT 'Test Procedure 03: usp_Test_InvalidProductReferences created successfully';
