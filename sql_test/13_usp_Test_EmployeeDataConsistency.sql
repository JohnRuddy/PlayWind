-- ============================================================================
-- Test 13: Employee Data Consistency Validation
-- ============================================================================
-- Validates that employee data is consistent and within reasonable ranges
-- Checks for impossible ages and data inconsistencies
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_EmployeeDataConsistency') IS NOT NULL 
    DROP PROCEDURE usp_Test_EmployeeDataConsistency;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_EmployeeDataConsistency
AS
BEGIN
    DECLARE @InvalidEmployees INT;
    
    -- Check for employees with impossible age (under 16 or over 100)
    SELECT @InvalidEmployees = COUNT(*)
    FROM Employees 
    WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) < 16 
       OR DATEDIFF(YEAR, BirthDate, GETDATE()) > 100;
    
    IF @InvalidEmployees > 0
        THROW 50035, 'Found Employees with impossible ages', 1;
    
    PRINT 'PASS: All employee ages are within reasonable ranges';
END
GO

PRINT 'Test Procedure 13: usp_Test_EmployeeDataConsistency created successfully';
