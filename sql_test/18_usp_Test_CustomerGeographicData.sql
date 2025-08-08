-- ============================================================================
-- Test 18: Customer Geographic Data Validation
-- ============================================================================
-- Validates that all customers have proper geographic information
-- Ensures complete customer location data
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_CustomerGeographicData') IS NOT NULL 
    DROP PROCEDURE usp_Test_CustomerGeographicData;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_CustomerGeographicData
AS
BEGIN
    DECLARE @CustomersWithoutLocation INT;
    
    -- Customers should have at least city information
    SELECT @CustomersWithoutLocation = COUNT(*)
    FROM Customers 
    WHERE City IS NULL OR LTRIM(RTRIM(City)) = '';
    
    IF @CustomersWithoutLocation > 0
        THROW 50040, 'Found Customers without geographic information', 1;
    
    PRINT 'PASS: All customers have geographic information';
END
GO

PRINT 'Test Procedure 18: usp_Test_CustomerGeographicData created successfully';
