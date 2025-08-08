-- ============================================================================
-- Test 28: Cross-Table Consistency Validation
-- ============================================================================
-- Validates consistency across multiple related tables
-- Ensures data coherence in cross-table relationships
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_CrossTableConsistency') IS NOT NULL 
    DROP PROCEDURE usp_Test_CrossTableConsistency;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_CrossTableConsistency
AS
BEGIN
    DECLARE @InconsistentData INT;
    
    -- Check for customers with orders but no contact info
    SELECT @InconsistentData = COUNT(*)
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE c.ContactName IS NULL AND c.Address IS NULL;
    
    IF @InconsistentData > 0
        THROW 50050, 'Found customers with orders but incomplete profile data', 1;
    
    PRINT 'PASS: Cross-table data consistency validated';
END
GO

PRINT 'Test Procedure 28: usp_Test_CrossTableConsistency created successfully';
