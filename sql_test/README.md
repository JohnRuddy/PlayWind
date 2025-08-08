# SQL Test Procedures - Individual Scripts

This folder contains **31 individual SQL scripts** for the Northwind Database Integrity Test Suite. Each script creates one stored procedure that validates a specific aspect of database integrity.

## 📁 File Structure

### Master Scripts
- `00_DEPLOY_ALL_TESTS.sql` - Master deployment script for all test procedures
- `99_QUICK_VALIDATION.sql` - Quick validation script to test all procedures

### Core Integrity Tests (01-10)
- `01_usp_Test_OrphanedOrderDetails.sql` - Validates OrderDetails integrity
- `02_usp_Test_OrphanedOrders.sql` - Validates Orders relationships  
- `03_usp_Test_InvalidProductReferences.sql` - Product reference validation
- `04_usp_Test_PrimaryKeyIntegrity.sql` - Primary key uniqueness
- `05_usp_Test_DataQuality.sql` - Name and required field validation
- `06_usp_Test_PriceValidation.sql` - Product price range validation
- `07_usp_Test_QuantityValidation.sql` - Order quantity validation
- `08_usp_Test_DateIntegrity.sql` - Date range and logic validation
- `09_usp_Test_BusinessRules.sql` - Core business rule compliance
- `10_usp_Test_ReferentialIntegrity.sql` - Complete referential validation

### Enhanced Business Logic Tests (11-20)
- `11_usp_Test_CustomerOrderConsistency.sql` - Customer-order relationships
- `12_usp_Test_ProductInventoryLogic.sql` - Product-supplier-category logic
- `13_usp_Test_EmployeeDataConsistency.sql` - Employee data validation
- `14_usp_Test_SupplierProductRelationship.sql` - Supplier relationships
- `15_usp_Test_OrderShippingLogic.sql` - Order shipping validation
- `16_usp_Test_CategoryProductDistribution.sql` - Category balance
- `17_usp_Test_PriceConsistencyAcrossOrders.sql` - Price consistency
- `18_usp_Test_CustomerGeographicData.sql` - Geographic data validation
- `19_usp_Test_OrderDateSequencing.sql` - Order sequence logic
- `20_usp_Test_ProductNameUniqueness.sql` - Product name validation

### Advanced Data Validation Tests (21-31)
- `21_usp_Test_EmployeeOrderLoad.sql` - Employee workload analysis
- `22_usp_Test_SupplierContactData.sql` - Supplier contact validation
- `23_usp_Test_OrderValueCalculation.sql` - Order value calculations
- `24_usp_Test_ProductUnitValidation.sql` - Product unit validation
- `25_usp_Test_CustomerOrderFrequency.sql` - Customer behavior analysis
- `26_usp_Test_ShipperPerformanceData.sql` - Shipper performance validation
- `27_usp_Test_DatabaseStatistics.sql` - Database health metrics
- `28_usp_Test_CrossTableConsistency.sql` - Cross-table validation
- `29_usp_Test_DataDuplication.sql` - Duplicate data detection
- `30_usp_Test_NullValueValidation.sql` - Critical null validation
- `31_usp_Test_StringDataValidation.sql` - String pattern validation

## 🚀 Usage Instructions

### Deploy All Tests at Once
```bash
# Navigate to sql_test folder
cd sql_test

# Deploy all procedures using SQL Server command line
sqlcmd -S "THINKPAD,58098" -U sa -P "Passw0rd1" -d "Northwind" -i "00_DEPLOY_ALL_TESTS.sql"
```

### Deploy Individual Tests
```bash
# Deploy a specific test procedure
sqlcmd -S "THINKPAD,58098" -U sa -P "Passw0rd1" -d "Northwind" -i "01_usp_Test_OrphanedOrderDetails.sql"
```

### Quick Validation
```bash
# Run quick validation of all deployed procedures
sqlcmd -S "THINKPAD,58098" -U sa -P "Passw0rd1" -d "Northwind" -i "99_QUICK_VALIDATION.sql"
```

### Execute Individual Tests
```sql
-- In SQL Server Management Studio or sqlcmd
EXEC usp_Test_OrphanedOrderDetails;
EXEC usp_Test_PrimaryKeyIntegrity;
EXEC usp_Test_ReferentialIntegrity;  -- Runs multiple tests
```

## 🎯 Test Categories

### **Core Integrity (Tests 1-10)**
Essential database validation including:
- Referential integrity
- Primary key uniqueness  
- Data quality standards
- Basic business rules

### **Enhanced Business Logic (Tests 11-20)**
Advanced business rule validation including:
- Customer-order relationships
- Product inventory logic
- Employee data consistency
- Supplier relationships

### **Advanced Data Validation (Tests 21-31)**
Comprehensive data analysis including:
- Statistical thresholds
- Cross-table consistency
- Data duplication detection
- Performance validation

## 📊 Integration with Test Framework

These individual SQL scripts are used by:
- `enhanced-database-integrity-tests.sql` - Combined deployment file
- `tests/enhanced-database-integrity.spec.js` - Playwright test automation
- `package.json` scripts for automated testing

## 🔧 Maintenance

### Adding New Tests
1. Create new SQL script following naming convention: `32_usp_Test_NewValidation.sql`
2. Update `00_DEPLOY_ALL_TESTS.sql` to include the new script
3. Update `99_QUICK_VALIDATION.sql` to test the new procedure
4. Add corresponding Playwright test in `enhanced-database-integrity.spec.js`

### Modifying Existing Tests
1. Edit the individual SQL script file
2. Redeploy using the individual script or master deployment
3. Verify changes with quick validation script

## 📈 Benefits of Individual Scripts

✅ **Modularity** - Deploy and test individual procedures  
✅ **Maintainability** - Easy to modify specific tests  
✅ **Version Control** - Track changes to individual tests  
✅ **Debugging** - Isolate and fix specific test issues  
✅ **Flexibility** - Deploy subset of tests as needed  
✅ **Documentation** - Each script is self-documenting  

## 🎉 Quick Start

1. **Deploy all tests**: Run `00_DEPLOY_ALL_TESTS.sql`
2. **Validate deployment**: Run `99_QUICK_VALIDATION.sql` 
3. **Run Playwright tests**: `npm run test:enhanced`
4. **View results**: `npx playwright show-report`

This modular approach provides maximum flexibility while maintaining the comprehensive testing framework!
