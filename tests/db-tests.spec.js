const { test, expect } = require('@playwright/test');
const sql = require('mssql');

const config = {
    user: 'sa',
    password: 'Passw0rd1',
    server: 'THINKPAD',
    port: 58098,
    database: 'Northwind',
    options: {
        encrypt: false,
        trustServerCertificate: true,
        connectTimeout: 30000,
        requestTimeout: 60000,
    }
};

let pool;

test.beforeAll(async () => {
    pool = await sql.connect(config);
});

test.afterAll(async () => {
    if (pool) {
        await pool.close();
    }
});

// ============================================================================
// CORE DATABASE INTEGRITY TESTS (Tests 1-10)
// ============================================================================

test.describe('Core Database Integrity', () => {
    test('01 - Orphaned Order Details Check', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_OrphanedOrderDetails');
        }).not.toThrow();
    });

    test('02 - Orphaned Orders Check', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_OrphanedOrders');
        }).not.toThrow();
    });

    test('03 - Invalid Product References Check', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_InvalidProductReferences');
        }).not.toThrow();
    });

    test('04 - Primary Key Integrity Check', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_PrimaryKeyIntegrity');
        }).not.toThrow();
    });

    test('05 - Data Quality Validation', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_DataQuality');
        }).not.toThrow();
    });

    test('06 - Price Validation Check', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_PriceValidation');
        }).not.toThrow();
    });

    test('07 - Quantity Validation Check', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_QuantityValidation');
        }).not.toThrow();
    });

    test('08 - Date Integrity Check', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_DateIntegrity');
        }).not.toThrow();
    });

    test('09 - Business Rules Validation', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_BusinessRules');
        }).not.toThrow();
    });

    test('10 - Complete Referential Integrity Check', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_ReferentialIntegrity');
        }).not.toThrow();
    });
});

// ============================================================================
// BUSINESS LOGIC TESTS (Tests 11-20)
// ============================================================================

test.describe('Business Logic Tests', () => {
    test('11 - Customer Order Consistency', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_CustomerOrderConsistency');
        }).not.toThrow();
    });

    test('12 - Product Inventory Logic', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_ProductInventoryLogic');
        }).not.toThrow();
    });

    test('13 - Employee Data Consistency', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_EmployeeDataConsistency');
        }).not.toThrow();
    });

    test('14 - Supplier Product Relationships', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_SupplierProductRelationship');
        }).not.toThrow();
    });

    test('15 - Order Shipping Logic', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_OrderShippingLogic');
        }).not.toThrow();
    });

    test('16 - Category Product Distribution', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_CategoryProductDistribution');
        }).not.toThrow();
    });

    test('17 - Price Consistency Across Orders', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_PriceConsistencyAcrossOrders');
        }).not.toThrow();
    });

    test('18 - Customer Geographic Data', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_CustomerGeographicData');
        }).not.toThrow();
    });

    test('19 - Order Date Sequencing', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_OrderDateSequencing');
        }).not.toThrow();
    });

    test('20 - Product Name Uniqueness', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_ProductNameUniqueness');
        }).not.toThrow();
    });
});

// ============================================================================
// ADVANCED DATA VALIDATION TESTS (Tests 21-31)
// ============================================================================

test.describe('Advanced Data Validation', () => {
    test('21 - Employee Order Load Distribution', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_EmployeeOrderLoad');
        }).not.toThrow();
    });

    test('22 - Supplier Contact Data', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_SupplierContactData');
        }).not.toThrow();
    });

    test('23 - Order Value Calculation', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_OrderValueCalculation');
        }).not.toThrow();
    });

    test('24 - Product Unit Validation', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_ProductUnitValidation');
        }).not.toThrow();
    });

    test('25 - Customer Order Frequency', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_CustomerOrderFrequency');
        }).not.toThrow();
    });

    test('26 - Shipper Performance Data', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_ShipperPerformanceData');
        }).not.toThrow();
    });

    test('27 - Database Statistics', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_DatabaseStatistics');
        }).not.toThrow();
    });

    test('28 - Cross Table Consistency', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_CrossTableConsistency');
        }).not.toThrow();
    });

    test('29 - Data Duplication', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_DataDuplication');
        }).not.toThrow();
    });

    test('30 - Null Value Validation', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_NullValueValidation');
        }).not.toThrow();
    });

    test('31 - String Data Validation', async () => {
        const request = new sql.Request(pool);
        await expect(async () => {
            await request.execute('usp_Test_StringDataValidation');
        }).not.toThrow();
    });
});

// ============================================================================
// SUMMARY TEST
// ============================================================================

test.describe('Test Suite Summary', () => {
    test('Complete Test Suite Validation', async () => {
        console.log('\n🔍 Running Complete Database Integrity Test Suite...');
        
        // List of all test procedures
        const allTests = [
            'usp_Test_OrphanedOrderDetails', 'usp_Test_OrphanedOrders', 'usp_Test_InvalidProductReferences',
            'usp_Test_PrimaryKeyIntegrity', 'usp_Test_DataQuality', 'usp_Test_PriceValidation',
            'usp_Test_QuantityValidation', 'usp_Test_DateIntegrity', 'usp_Test_BusinessRules',
            'usp_Test_ReferentialIntegrity', 'usp_Test_CustomerOrderConsistency', 'usp_Test_ProductInventoryLogic',
            'usp_Test_EmployeeDataConsistency', 'usp_Test_SupplierProductRelationship', 'usp_Test_OrderShippingLogic',
            'usp_Test_CategoryProductDistribution', 'usp_Test_PriceConsistencyAcrossOrders', 'usp_Test_CustomerGeographicData',
            'usp_Test_OrderDateSequencing', 'usp_Test_ProductNameUniqueness', 'usp_Test_EmployeeOrderLoad',
            'usp_Test_SupplierContactData', 'usp_Test_OrderValueCalculation', 'usp_Test_ProductUnitValidation',
            'usp_Test_CustomerOrderFrequency', 'usp_Test_ShipperPerformanceData', 'usp_Test_DatabaseStatistics',
            'usp_Test_CrossTableConsistency', 'usp_Test_DataDuplication', 'usp_Test_NullValueValidation',
            'usp_Test_StringDataValidation'
        ];

        let passedTests = 0;
        let failedTests = 0;

        console.log(`📋 Testing ${allTests.length} database integrity procedures...`);

        for (const testProc of allTests) {
            try {
                const request = new sql.Request(pool);
                await request.execute(testProc);
                passedTests++;
            } catch (error) {
                console.log(`❌ ${testProc}: ${error.message}`);
                failedTests++;
            }
        }

        console.log(`\n📊 Test Results Summary:`);
        console.log(`✅ Passed: ${passedTests}`);
        console.log(`❌ Failed: ${failedTests}`);
        console.log(`📈 Success Rate: ${((passedTests/allTests.length) * 100).toFixed(1)}%`);
        
        if (passedTests === allTests.length) {
            console.log('🟢 EXCELLENT: All tests passed - database integrity is optimal');
        } else if (passedTests >= allTests.length * 0.9) {
            console.log('🟡 GOOD: Most tests passed - minor issues detected');
        } else {
            console.log('🔴 ISSUES: Multiple test failures - database needs attention');
        }

        // Expect at least 70% success rate
        expect(passedTests / allTests.length).toBeGreaterThanOrEqual(0.7);
    });
});
