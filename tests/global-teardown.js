/**
 * Global Teardown for Northwind Database Tests
 * 
 * This file runs after all tests complete and performs cleanup operations.
 */

const sql = require('mssql');

async function globalTeardown() {
  console.log('🧹 Cleaning up after Northwind Database Tests...');
  
  try {
    // Close any remaining SQL connections
    await sql.close();
    console.log('✅ Database connections closed');
    console.log('🎉 Teardown complete!');
    
  } catch (error) {
    console.log('⚠️  Teardown warning:', error.message);
    // Don't throw error in teardown unless critical
  }
}

module.exports = globalTeardown;
