const { closeBrowser, openBrowser, goto, title, screenshot } = require('taiko');
import assert from 'assert';

describe('Something', () => {
  beforeEach('Launch', async () => {
    await openBrowser();
  });

  afterEach('Close', async () => {
    await closeBrowser();
  });
  it('First Test', async () => {
    await goto('google.com');
    await screenshot();
    assert.equal(await title(), 'Google');
  });
});
