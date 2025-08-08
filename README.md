# Northwind Database Integrity Testing Framework

A comprehensive Playwright-based testing framework for validating the integrity of the Northwind database with 31 automated test procedures.

## 🎯 Features

- **31 Comprehensive Tests** covering all aspects of database integrity
- **Automated Execution** via Playwright test framework
- **Detailed Reporting** with HTML reports and console output
- **Modular Design** with individual SQL scripts for maintenance
- **Performance Monitoring** with execution time tracking

## 📁 Project Structure

```
c:\Projects\Northwnd\
├── tests/
│   ├── database-integrity.spec.js    # Main test suite (31 tests)
│   ├── global-setup.js               # Test environment setup
│   └── global-teardown.js            # Cleanup procedures
├── sql_test/
│   ├── 01-31_usp_Test_*.sql          # Individual test procedures
│   ├── 00_DEPLOY_ALL_TESTS.sql       # Master deployment script
│   └── 99_QUICK_VALIDATION.sql       # Quick validation script
├── enhanced-database-integrity-tests.sql  # Complete test suite
├── playwright.config.js              # Test configuration
├── package.json                      # Dependencies and scripts
└── README.md                         # This file
```

## 🚀 Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Deploy Test Procedures
```bash
npm run deploy-tests
```

### 3. Run Tests
```bash
npm test
```

### 4. View Results
```bash
npm run report
```

## 📊 Test Categories

### Core Database Integrity (10 tests)
- Orphaned record detection
- Primary key validation
- Referential integrity checks
- Data quality validation
- Price and quantity validation
- Date integrity checks
- Business rule compliance

### Business Logic Validation (10 tests)
- Customer-order consistency
- Product inventory logic
- Employee data validation
- Supplier relationships
- Order shipping logic
- Category distribution
- Geographic data validation

### Advanced Data Validation (11 tests)
- Employee workload analysis
- Contact data completeness
- Order value calculations
- Data duplication detection
- Null value validation
- String pattern validation
- Cross-table consistency

## 🛠️ Available Scripts

| Script | Description |
|--------|-------------|
| `npm test` | Run all database integrity tests |
| `npm run test:debug` | Run tests in debug mode |
| `npm run test:ui` | Run tests with UI mode |
| `npm run test:headed` | Run tests in headed browser mode |
| `npm run report` | Open HTML test report |
| `npm run deploy-tests` | Deploy all test procedures to database |
| `npm run deploy-individual` | Deploy using individual SQL scripts |
| `npm run validate-sql` | Quick validation of deployed procedures |

## 🔧 Configuration

### Database Connection
Update connection settings in `tests/database-integrity.spec.js`:
```javascript
const config = {
    user: 'sa',
    password: 'Passw0rd1',
    server: 'THINKPAD',
    port: 58098,
    database: 'Northwind',
    // ... other options
};
```

### Test Timeouts
Configured in `playwright.config.js`:
- Test timeout: 60 seconds
- Expect timeout: 30 seconds
- Action timeout: 45 seconds

## 📈 Test Results

The framework provides comprehensive reporting:
- ✅ **Pass/Fail status** for each test
- 📊 **Success rate** calculations
- 🎯 **Database health assessment**
- ⏱️ **Performance metrics**
- 📋 **Detailed error messages** for failures

## 🏗️ Database Test Procedures

All test procedures follow the naming convention: `usp_Test_[TestName]`

**Examples:**
- `usp_Test_OrphanedOrderDetails` - Detects orphaned order detail records
- `usp_Test_PrimaryKeyIntegrity` - Validates primary key uniqueness
- `usp_Test_ReferentialIntegrity` - Comprehensive referential checks

## 🎨 Customization

### Adding New Tests
1. Create SQL procedure in `sql_test/` folder
2. Add to `00_DEPLOY_ALL_TESTS.sql`
3. Add corresponding Playwright test
4. Update validation script

### Modifying Existing Tests
1. Edit the SQL procedure file
2. Redeploy using `npm run deploy-tests`
3. Run tests to verify changes

## 🔍 Troubleshooting

### Common Issues
- **Connection timeouts**: Check SQL Server is running on correct port
- **Authentication failures**: Verify username/password
- **Test failures**: Run `npm run validate-sql` to check procedures

### Debug Mode
Use `npm run test:debug` for step-by-step debugging

## 📝 Requirements

- **Node.js** 14+ with npm
- **SQL Server** with Northwind database
- **Playwright** test framework
- **mssql** package for database connectivity

## 🎉 Success Metrics

A healthy database should achieve:
- ✅ **100% test pass rate** for core integrity tests
- ✅ **>90% overall success rate** for all tests
- ✅ **<5 second execution time** per test
- ✅ **Zero critical data integrity issues**

---

**Database Status**: All 31 tests currently **PASSING** ✅  
**Success Rate**: **100%** 🎯  
**Database Health**: **EXCELLENT** 🟢
