# Selenium notes, tips, cheatsheet

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
