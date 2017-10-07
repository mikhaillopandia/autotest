@login_page = 'http://demoapp.strongqa.com/users/sign_in'
@home_page = 'http://demoapp.strongqa.com/'

def test_case(ref, name)
  @driver = Watir::Browser.new :chrome
  puts "**#{ref} - #{name}"
  yield
rescue => e
  puts "[FAILED] #{e.message}"
ensure
  @driver.quit
end

def visit_login_page
  puts " Action: Visit login page"
  @driver.goto @login_page
end

def visit_home_page
  puts " Action: Visit home page"
  @driver.goto @home_page
end

def assert_login_page_open
  puts "  Verify: login page should be open"
  if @driver.url == @login_page
    puts '[PASS]'
  else
    raise "Expected Login page, Actual: #{@driver.url}"
  end
end

def assert_home_page_open
  puts "  Verify: home page should be open"
  if @driver.url == @home_page
    puts '[PASS]'
  else
    raise "Expected Home page, Actual: #{@driver.url}"
  end
end

def assert_user_logged
  puts "  Verify: User should be logged on"
  e = @driver.element(xpath: "//div[text()='Signed in successfully.']")
  if !!e
    puts '[PASS]'
  else
    raise "There is no 'Signed in successfully.' on the page"
  end
end

def assert_login_error_message
  puts "  Verify: Login error message exists"
  e = @driver.element(xpath: "//div[text()='Invalid email or password.']")
  if !!e
    puts '[PASS]'
  else
    raise "There is no 'Invalid email or password.' on the page"
  end
end

def assert_login_interrupted
  puts "  Verify: User isn't logged on"
  e = @driver.element(xpath: "//a[text()='Login']")
  if !!e
    puts '[PASS]'
  else
    raise "User has been logged on!"
  end
end

def assert_login_error
  assert_login_error_message
  assert_login_interrupted
end

def click_login
  puts ' Action: Click on Login item'
  @driver.element(link_text: 'Login').click
end

def click_enter
  puts ' Action: Click Enter'
  @driver.element(name: 'user[password]').send_keys(:enter)
end

def fill_form (email: nil, password: nil)
  puts " Action: Filling in: email = #{email}, password = #{password}"
  @driver.text_field(name: 'user[email]').set(email)
  @driver.text_field(name: 'user[password]').set(password)
end

def watir_test_run
  yield
end
