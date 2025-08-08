-- ============================================================================
-- Test 9: Business Rules Validation
-- ============================================================================
-- Validates core business rules compliance
-- Checks that Orders have OrderDetails and Categories have Products
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_BusinessRules') IS NOT NULL 
    DROP PROCEDURE usp_Test_BusinessRules;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_BusinessRules
AS
BEGIN
    DECLARE @OrdersWithoutDetails INT, @CategoriesWithoutProducts INT;
    
    SELECT @OrdersWithoutDetails = COUNT(*)
    FROM Orders o
    LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE od.OrderID IS NULL;
    IF @OrdersWithoutDetails > 0 THROW 50030, 'Found Orders without any OrderDetails', 1;
    
    SELECT @CategoriesWithoutProducts = COUNT(*)
    FROM Categories c
    LEFT JOIN Products p ON c.CategoryID = p.CategoryID
    WHERE p.CategoryID IS NULL;
    IF @CategoriesWithoutProducts > 0 THROW 50031, 'Found Categories without any Products', 1;
    
    PRINT 'PASS: All business rules are satisfied';
END
GO

PRINT 'Test Procedure 09: usp_Test_BusinessRules created successfully';
