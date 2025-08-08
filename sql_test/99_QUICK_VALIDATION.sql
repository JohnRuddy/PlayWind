-- ============================================================================
-- QUICK VALIDATION SCRIPT - Test All Procedures
-- ============================================================================
-- This script quickly validates that all test procedures are deployed
-- and can be executed successfully
-- ============================================================================

PRINT '=== QUICK VALIDATION OF ALL TEST PROCEDURES ===';
PRINT 'Testing execution of all 31 test procedures...';
PRINT '';

DECLARE @TestCount INT = 0;
DECLARE @PassCount INT = 0;
DECLARE @FailCount INT = 0;

-- Test 1-10: Core Integrity Tests
PRINT '--- TESTING CORE INTEGRITY TESTS (1-10) ---';

BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_OrphanedOrderDetails; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 1 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_OrphanedOrders; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 2 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_InvalidProductReferences; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 3 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_PrimaryKeyIntegrity; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 4 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_DataQuality; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 5 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_PriceValidation; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 6 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_QuantityValidation; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 7 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_DateIntegrity; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 8 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_BusinessRules; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 9 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_ReferentialIntegrity; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 10 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;

-- Test 11-20: Enhanced Business Logic Tests  
PRINT '';
PRINT '--- TESTING ENHANCED BUSINESS LOGIC TESTS (11-20) ---';

BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_CustomerOrderConsistency; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 11 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_ProductInventoryLogic; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 12 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_EmployeeDataConsistency; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 13 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_SupplierProductRelationship; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 14 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_OrderShippingLogic; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 15 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_CategoryProductDistribution; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 16 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_PriceConsistencyAcrossOrders; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 17 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_CustomerGeographicData; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 18 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_OrderDateSequencing; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 19 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_ProductNameUniqueness; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 20 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;

-- Test 21-31: Advanced Data Validation Tests
PRINT '';
PRINT '--- TESTING ADVANCED DATA VALIDATION TESTS (21-31) ---';

BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_EmployeeOrderLoad; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 21 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_SupplierContactData; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 22 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_OrderValueCalculation; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 23 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_ProductUnitValidation; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 24 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_CustomerOrderFrequency; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 25 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_ShipperPerformanceData; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 26 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_DatabaseStatistics; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 27 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_CrossTableConsistency; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 28 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_DataDuplication; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 29 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_NullValueValidation; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 30 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;
BEGIN TRY SET @TestCount = @TestCount + 1; EXEC usp_Test_StringDataValidation; SET @PassCount = @PassCount + 1; END TRY BEGIN CATCH PRINT 'FAIL: Test 31 - ' + ERROR_MESSAGE(); SET @FailCount = @FailCount + 1; END CATCH;

-- Summary
PRINT '';
PRINT '=== VALIDATION SUMMARY ===';
PRINT 'Total Tests: ' + CAST(@TestCount AS VARCHAR(10));
PRINT 'Passed: ' + CAST(@PassCount AS VARCHAR(10));
PRINT 'Failed: ' + CAST(@FailCount AS VARCHAR(10));
PRINT 'Success Rate: ' + CAST((@PassCount * 100.0 / @TestCount) AS VARCHAR(10)) + '%';

IF @FailCount = 0
    PRINT '🎉 ALL TESTS PASSED - Database integrity is EXCELLENT!';
ELSE
    PRINT '⚠️  Some tests failed - Review database integrity issues above';

PRINT '';
PRINT 'Quick validation completed!';
