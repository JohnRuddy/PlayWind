-- ============================================================================
-- MASTER DEPLOYMENT SCRIPT - Deploy All Test Procedures
-- ============================================================================
-- This script deploys all 31 database integrity test procedures
-- Execute this script to deploy the complete test suite to your database
-- ============================================================================

PRINT '=== STARTING NORTHWIND DATABASE INTEGRITY TEST SUITE DEPLOYMENT ===';
PRINT 'Deploying 31 comprehensive test procedures...';
PRINT '';

-- Core Integrity Tests (1-10)
PRINT '--- DEPLOYING CORE INTEGRITY TESTS (1-10) ---';

:r 01_usp_Test_OrphanedOrderDetails.sql
:r 02_usp_Test_OrphanedOrders.sql
:r 03_usp_Test_InvalidProductReferences.sql
:r 04_usp_Test_PrimaryKeyIntegrity.sql
:r 05_usp_Test_DataQuality.sql
:r 06_usp_Test_PriceValidation.sql
:r 07_usp_Test_QuantityValidation.sql
:r 08_usp_Test_DateIntegrity.sql
:r 09_usp_Test_BusinessRules.sql
:r 10_usp_Test_ReferentialIntegrity.sql

PRINT '';
PRINT '--- DEPLOYING ENHANCED BUSINESS LOGIC TESTS (11-20) ---';

:r 11_usp_Test_CustomerOrderConsistency.sql
:r 12_usp_Test_ProductInventoryLogic.sql
:r 13_usp_Test_EmployeeDataConsistency.sql
:r 14_usp_Test_SupplierProductRelationship.sql
:r 15_usp_Test_OrderShippingLogic.sql
:r 16_usp_Test_CategoryProductDistribution.sql
:r 17_usp_Test_PriceConsistencyAcrossOrders.sql
:r 18_usp_Test_CustomerGeographicData.sql
:r 19_usp_Test_OrderDateSequencing.sql
:r 20_usp_Test_ProductNameUniqueness.sql

PRINT '';
PRINT '--- DEPLOYING ADVANCED DATA VALIDATION TESTS (21-31) ---';

:r 21_usp_Test_EmployeeOrderLoad.sql
:r 22_usp_Test_SupplierContactData.sql
:r 23_usp_Test_OrderValueCalculation.sql
:r 24_usp_Test_ProductUnitValidation.sql
:r 25_usp_Test_CustomerOrderFrequency.sql
:r 26_usp_Test_ShipperPerformanceData.sql
:r 27_usp_Test_DatabaseStatistics.sql
:r 28_usp_Test_CrossTableConsistency.sql
:r 29_usp_Test_DataDuplication.sql
:r 30_usp_Test_NullValueValidation.sql
:r 31_usp_Test_StringDataValidation.sql

PRINT '';
PRINT '=== DEPLOYMENT COMPLETED SUCCESSFULLY ===';
PRINT '✅ All 31 test procedures have been deployed to the database';
PRINT '';
PRINT 'Test Categories:';
PRINT '  • Core Integrity Tests (1-10): Basic validation and referential integrity';
PRINT '  • Enhanced Business Logic Tests (11-20): Advanced business rules and relationships';
PRINT '  • Advanced Data Validation Tests (21-31): Complex validation and consistency checks';
PRINT '';
PRINT 'Usage Examples:';
PRINT '  EXEC usp_Test_OrphanedOrderDetails;         -- Run individual test';
PRINT '  EXEC usp_Test_ReferentialIntegrity;         -- Run core integrity suite';
PRINT '  -- Use Playwright tests for comprehensive execution';
PRINT '';
PRINT 'Next Steps:';
PRINT '  1. Run: npm run test:enhanced';
PRINT '  2. View results: npm run test:enhanced:comprehensive';
PRINT '  3. Open reports: npx playwright show-report';
PRINT '';
PRINT 'Database Integrity Test Suite deployment complete! 🎉';
