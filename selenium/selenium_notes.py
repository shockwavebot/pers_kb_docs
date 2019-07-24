# chrome  
from selenium import webdriver
driver = webdriver.Chrome()

# JS code to wait until page load is complete
drv.execute_script("return document.readyState") # returns 'complete'

# get html code of an element
elem.get_attribute('outerHTML')
# get html code inside the element
elem.get_attribute('innerHTML')
# get element text
elem.text

# get the list of all attributes of one element
element = driver.find_element_by_css_selector("img")
driver.execute_script(\
'var items = {};\
for (index = 0; index < arguments[0].attributes.length; ++index)\
{ items[arguments[0].attributes[index].name] = arguments[0].attributes[index].value };\
return items;', element)
{'class': 'frame', 'src': 'yoda.jpg'} # RESULT

# mouse hover
from selenium.webdriver.common.action_chains import ActionChains
hover = ActionChains(driver).move_to_element(elem)
hover.perform()

# page zoom in for Chrome
driver.execute_script("document.body.style.zoom = '1.5'")

# capture screen shot
driver.save_screenshot(‘/path/to/img.png’)
driver.get_screenshot_as_file(‘/path/to/img.png’)
driver.get_screenshot_as_png()
driver.get_screenshot_as_base64()

# switching between windows/tabs
driver.window_handles
driver.switch_to_window(handle)

####################################################
# event listener
# https://github.com/browserstack/selenium-webdriver-python/blob/85573164744ce5345044cc8785c429b3cc0cdbe2/selenium/webdriver/support/abstract_event_listener.py
from selenium.webdriver.support.events import EventFiringWebDriver, AbstractEventListener

class MyListener(AbstractEventListener):
    def before_navigate_to(self, url, driver):
        print("Log: Before navigate to {}".format(url))
    def after_navigate_to(self, url, driver):
        print("Log: After navigate to {}".format(url))

driver = webdriver.Chrome()
ef_driver = EventFiringWebDriver(driver, MyListener())
ef_driver.get("http://python.org")
####################################################

####################################################
# handling select options drop down menu
from selenium.webdriver.support import select

ddm = select.Select(driver.find_element_by_id('designation'))
ddm.select_by_value('prog')

####################################################
