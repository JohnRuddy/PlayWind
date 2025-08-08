-- ============================================================================
-- Test 8: Date Integrity Validation
-- ============================================================================
-- Validates that all dates are within reasonable ranges
-- Checks for future dates and dates before reasonable thresholds
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_DateIntegrity') IS NOT NULL 
    DROP PROCEDURE usp_Test_DateIntegrity;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_DateIntegrity
AS
BEGIN
    DECLARE @InvalidDates INT;
    
    SELECT @InvalidDates = COUNT(*) FROM Orders WHERE OrderDate > GETDATE();
    IF @InvalidDates > 0 THROW 50026, 'Found Orders with future OrderDate', 1;
    
    SELECT @InvalidDates = COUNT(*) FROM Orders WHERE OrderDate < '1990-01-01';
    IF @InvalidDates > 0 THROW 50027, 'Found Orders with OrderDate before 1990', 1;
    
    SELECT @InvalidDates = COUNT(*) FROM Employees WHERE BirthDate > GETDATE();
    IF @InvalidDates > 0 THROW 50028, 'Found Employees with future BirthDate', 1;
    
    SELECT @InvalidDates = COUNT(*) FROM Employees WHERE BirthDate < '1920-01-01';
    IF @InvalidDates > 0 THROW 50029, 'Found Employees with BirthDate before 1920', 1;
    
    PRINT 'PASS: All dates are within reasonable ranges';
END
GO

PRINT 'Test Procedure 08: usp_Test_DateIntegrity created successfully';
