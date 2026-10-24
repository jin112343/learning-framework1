require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  setup do
    browser = page.driver.browser
    browser.execute_cdp('Network.enable')
    browser.execute_cdp('Network.setExtraHTTPHeaders', headers: {
      'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials('test-owner', 'test-only-password')
    })
  end
end
