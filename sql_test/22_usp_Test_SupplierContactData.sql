-- ============================================================================
-- Test 22: Supplier Contact Data Completeness Validation
-- ============================================================================
-- Validates that all suppliers have adequate contact information
-- Ensures suppliers maintain proper communication channels
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_SupplierContactData') IS NOT NULL 
    DROP PROCEDURE usp_Test_SupplierContactData;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_SupplierContactData
AS
BEGIN
    DECLARE @SuppliersWithoutContact INT;
    
    -- Suppliers should have contact information
    SELECT @SuppliersWithoutContact = COUNT(*)
    FROM Suppliers 
    WHERE (ContactName IS NULL OR LTRIM(RTRIM(ContactName)) = '')
    AND (Phone IS NULL OR LTRIM(RTRIM(Phone)) = '');
    
    IF @SuppliersWithoutContact > 0
        THROW 50043, 'Found Suppliers without any contact information', 1;
    
    PRINT 'PASS: All suppliers have contact information';
END
GO

PRINT 'Test Procedure 22: usp_Test_SupplierContactData created successfully';
