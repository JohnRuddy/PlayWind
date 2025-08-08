-- ============================================================================
-- Test 11: Customer Order Consistency Validation
-- ============================================================================
-- Validates that customers with orders have proper contact information
-- Ensures active customers maintain complete profile data
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_CustomerOrderConsistency') IS NOT NULL 
    DROP PROCEDURE usp_Test_CustomerOrderConsistency;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_CustomerOrderConsistency
AS
BEGIN
    DECLARE @InconsistentCustomers INT;
    
    -- Check for customers with orders but missing contact information
    SELECT @InconsistentCustomers = COUNT(*)
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE c.ContactName IS NULL OR LTRIM(RTRIM(c.ContactName)) = '';
    
    IF @InconsistentCustomers > 0
        THROW 50032, 'Found active customers without proper contact information', 1;
    
    PRINT 'PASS: All customers with orders have proper contact information';
END
GO

PRINT 'Test Procedure 11: usp_Test_CustomerOrderConsistency created successfully';
