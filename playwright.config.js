// @ts-check
const { defineConfig } = require('@playwright/test');

/**
 * Playwright Configuration for Northwind Database Integrity Tests
 * Optimized for database testing with appropriate timeouts and reporting
 */
module.exports = defineConfig({
  testDir: './tests',
  timeout: 60000,
  expect: { timeout: 30000 },
  fullyParallel: false,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 1,
  workers: 1,
  
  reporter: [
    ['list'],
    ['json', { outputFile: 'test-results/results.json' }],
    ['html']
  ],
  
  use: {
    trace: 'retain-on-failure',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure'
  },

  globalSetup: require.resolve('./tests/global-setup.js'),
  globalTeardown: require.resolve('./tests/global-teardown.js')
});
