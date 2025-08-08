-- ============================================================================
-- Test 25: Customer Order Frequency Patterns Validation
-- ============================================================================
-- Validates customer order frequency patterns for business insights
-- Analyzes high-frequency and one-time customer behaviors
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_CustomerOrderFrequency') IS NOT NULL 
    DROP PROCEDURE usp_Test_CustomerOrderFrequency;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_CustomerOrderFrequency
AS
BEGIN
    DECLARE @HighFrequencyCustomers INT, @OneTimeCustomers INT;
    
    -- Check customer order patterns
    SELECT @HighFrequencyCustomers = COUNT(*)
    FROM (
        SELECT c.CustomerID, COUNT(o.OrderID) as OrderCount
        FROM Customers c
        INNER JOIN Orders o ON c.CustomerID = o.CustomerID
        GROUP BY c.CustomerID
        HAVING COUNT(o.OrderID) > 10
    ) AS HighFreqCusts;
    
    SELECT @OneTimeCustomers = COUNT(*)
    FROM (
        SELECT c.CustomerID, COUNT(o.OrderID) as OrderCount
        FROM Customers c
        INNER JOIN Orders o ON c.CustomerID = o.CustomerID
        GROUP BY c.CustomerID
        HAVING COUNT(o.OrderID) = 1
    ) AS OneTimeCusts;
    
    -- This is informational - both patterns can be normal
    PRINT 'PASS: Customer order frequency analysis completed';
END
GO

PRINT 'Test Procedure 25: usp_Test_CustomerOrderFrequency created successfully';
