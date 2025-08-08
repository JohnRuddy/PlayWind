-- ============================================================================
-- Test 29: Data Duplication Detection
-- ============================================================================
-- Validates that no duplicate customer or supplier records exist
-- Checks for potential data quality issues with duplicates
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_DataDuplication') IS NOT NULL 
    DROP PROCEDURE usp_Test_DataDuplication;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_DataDuplication
AS
BEGIN
    DECLARE @DuplicateCustomers INT, @DuplicateSuppliers INT;
    
    -- Check for potential duplicate customers (same name and city)
    SELECT @DuplicateCustomers = COUNT(*) - COUNT(DISTINCT CustomerName + ISNULL(City, ''))
    FROM Customers
    WHERE CustomerName IS NOT NULL;
    
    -- Check for potential duplicate suppliers
    SELECT @DuplicateSuppliers = COUNT(*) - COUNT(DISTINCT SupplierName + ISNULL(City, ''))
    FROM Suppliers
    WHERE SupplierName IS NOT NULL;
    
    IF @DuplicateCustomers > 0
        THROW 50051, 'Found potential duplicate customers', 1;
        
    IF @DuplicateSuppliers > 0
        THROW 50052, 'Found potential duplicate suppliers', 1;
    
    PRINT 'PASS: No duplicate customer or supplier records found';
END
GO

PRINT 'Test Procedure 29: usp_Test_DataDuplication created successfully';
