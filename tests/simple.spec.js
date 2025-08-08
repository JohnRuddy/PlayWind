const { test, expect } = require('@playwright/test');

test('simple test', async () => {
    expect(1 + 1).toBe(2);
});
