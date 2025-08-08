/**
 * Global Setup for Northwind Database Tests
 * 
 * This file runs before any tests and ensures the database is ready
 * and all test procedures are properly deployed.
 */

const sql = require('mssql');

const config = {
  server: 'THINKPAD',
  port: 58098,
  database: 'Northwind',
  user: 'sa',
  password: 'Passw0rd1',
  options: {
    encrypt: false,
    trustServerCertificate: true,
    enableArithAbort: true,
  }
};

async function globalSetup() {
  console.log('🔧 Setting up Northwind Database Tests...');
  
  try {
    // Test database connection
    const pool = await sql.connect(config);
    console.log('✅ Database connection established');
    
    // Verify test procedures exist
    const procedureCheck = await pool.request().query(`
      SELECT COUNT(*) as ProcCount
      FROM sys.procedures 
      WHERE name LIKE 'usp_Test_%'
    `);
    
    const procCount = procedureCheck.recordset[0].ProcCount;
    console.log(`✅ Found ${procCount} test procedures`);
    
    if (procCount < 10) {
      console.log('⚠️  Some test procedures may be missing. Please run database-integrity-tests.sql');
    }
    
    // Check database has data
    const tableCheck = await pool.request().query(`
      SELECT 
        (SELECT COUNT(*) FROM Orders) as OrderCount,
        (SELECT COUNT(*) FROM Customers) as CustomerCount,
        (SELECT COUNT(*) FROM Products) as ProductCount
    `);
    
    const counts = tableCheck.recordset[0];
    console.log(`✅ Database contains: ${counts.OrderCount} orders, ${counts.CustomerCount} customers, ${counts.ProductCount} products`);
    
    await pool.close();
    console.log('🚀 Setup complete - ready to run tests!');
    
  } catch (error) {
    console.error('❌ Setup failed:', error.message);
    throw error;
  }
}

module.exports = globalSetup;
