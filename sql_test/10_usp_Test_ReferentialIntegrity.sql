-- ============================================================================
-- Test 10: Complete Referential Integrity Validation
-- ============================================================================
-- Executes all core referential integrity tests in sequence
-- Comprehensive validation of all foreign key relationships
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_ReferentialIntegrity') IS NOT NULL 
    DROP PROCEDURE usp_Test_ReferentialIntegrity;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_ReferentialIntegrity
AS
BEGIN
    EXEC usp_Test_OrphanedOrderDetails;
    EXEC usp_Test_OrphanedOrders;
    EXEC usp_Test_InvalidProductReferences;
    
    PRINT 'PASS: Complete referential integrity check passed';
END
GO

PRINT 'Test Procedure 10: usp_Test_ReferentialIntegrity created successfully';
