-- ============================================================================
-- Test 5: Data Quality Validation
-- ============================================================================
-- Validates that all required name fields contain valid data
-- Checks for empty or null name fields across all core tables
-- ============================================================================

-- Drop procedure if it exists
IF OBJECT_ID('usp_Test_DataQuality') IS NOT NULL 
    DROP PROCEDURE usp_Test_DataQuality;
GO

-- Create the test procedure
CREATE PROCEDURE usp_Test_DataQuality
AS
BEGIN
    DECLARE @InvalidCount INT;
    
    -- Check for required name fields
    SELECT @InvalidCount = COUNT(*) FROM Categories WHERE CategoryName IS NULL OR LTRIM(RTRIM(CategoryName)) = '';
    IF @InvalidCount > 0 THROW 50016, 'Found Categories with empty CategoryName', 1;
    
    SELECT @InvalidCount = COUNT(*) FROM Customers WHERE CustomerName IS NULL OR LTRIM(RTRIM(CustomerName)) = '';
    IF @InvalidCount > 0 THROW 50017, 'Found Customers with empty CustomerName', 1;
    
    SELECT @InvalidCount = COUNT(*) FROM Products WHERE ProductName IS NULL OR LTRIM(RTRIM(ProductName)) = '';
    IF @InvalidCount > 0 THROW 50018, 'Found Products with empty ProductName', 1;
    
    SELECT @InvalidCount = COUNT(*) FROM Suppliers WHERE SupplierName IS NULL OR LTRIM(RTRIM(SupplierName)) = '';
    IF @InvalidCount > 0 THROW 50019, 'Found Suppliers with empty SupplierName', 1;
    
    SELECT @InvalidCount = COUNT(*) FROM Shippers WHERE ShipperName IS NULL OR LTRIM(RTRIM(ShipperName)) = '';
    IF @InvalidCount > 0 THROW 50020, 'Found Shippers with empty ShipperName', 1;
    
    SELECT @InvalidCount = COUNT(*) FROM Employees 
    WHERE (FirstName IS NULL OR LTRIM(RTRIM(FirstName)) = '') OR (LastName IS NULL OR LTRIM(RTRIM(LastName)) = '');
    IF @InvalidCount > 0 THROW 50021, 'Found Employees with empty FirstName or LastName', 1;
    
    PRINT 'PASS: All required name fields contain valid data';
END
GO

PRINT 'Test Procedure 05: usp_Test_DataQuality created successfully';
