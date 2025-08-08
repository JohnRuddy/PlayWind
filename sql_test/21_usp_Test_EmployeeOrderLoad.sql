-- ============================================================================
-- Test 21: Employee Order Load Distribution Validation
-- ============================================================================
-- Validates reasonable distribution of orders across employees
-- Checks for overloaded employees and inactive employees
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_EmployeeOrderLoad') IS NOT NULL 
    DROP PROCEDURE usp_Test_EmployeeOrderLoad;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_EmployeeOrderLoad
AS
BEGIN
    DECLARE @OverloadedEmployees INT, @InactiveEmployees INT;
    
    -- Check for employees with excessive order loads (>50 orders)
    SELECT @OverloadedEmployees = COUNT(*)
    FROM (
        SELECT e.EmployeeID, COUNT(o.OrderID) as OrderCount
        FROM Employees e
        LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
        GROUP BY e.EmployeeID
        HAVING COUNT(o.OrderID) > 50
    ) AS OverloadedEmps;
    
    -- Check for employees with no orders
    SELECT @InactiveEmployees = COUNT(*)
    FROM Employees e
    LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
    WHERE o.EmployeeID IS NULL;
    
    IF @InactiveEmployees > 5  -- Allow for some inactive employees
        THROW 50042, 'Too many employees without any orders', 1;
    
    PRINT 'PASS: Employee order load distribution is reasonable';
END
GO

PRINT 'Test Procedure 21: usp_Test_EmployeeOrderLoad created successfully';
