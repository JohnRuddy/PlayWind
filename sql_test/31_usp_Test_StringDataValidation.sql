-- ============================================================================
-- Test 31: String Data Validation Patterns
-- ============================================================================
-- Validates string data patterns for suspicious or test data
-- Checks for potential data quality issues in string fields
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_StringDataValidation') IS NOT NULL 
    DROP PROCEDURE usp_Test_StringDataValidation;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_StringDataValidation
AS
BEGIN
    DECLARE @InvalidStrings INT;
    
    -- Check for suspicious string patterns
    SELECT @InvalidStrings = COUNT(*)
    FROM (
        SELECT CustomerName FROM Customers WHERE CustomerName LIKE '%[0-9][0-9][0-9][0-9][0-9]%'
        UNION ALL
        SELECT ProductName FROM Products WHERE ProductName LIKE '%TEST%' OR ProductName LIKE '%TEMP%'
        UNION ALL
        SELECT SupplierName FROM Suppliers WHERE SupplierName LIKE '%TEST%'
    ) AS SuspiciousData;
    
    -- This is often normal, so we'll be lenient
    IF @InvalidStrings > 10
        THROW 50054, 'Found excessive suspicious string patterns', 1;
    
    PRINT 'PASS: String data patterns appear normal';
END
GO

PRINT 'Test Procedure 31: usp_Test_StringDataValidation created successfully';
