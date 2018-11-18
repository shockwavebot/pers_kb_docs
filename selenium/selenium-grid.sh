# Installing and setup of Selenium Grid on Linux


#######################################################################################################
# openSuse Leap 42.3 # installed with Java development pkgs
# download jar file from http://selenium-release.storage.googleapis.com/index.html

mstan@grid-suse:~> java -version
openjdk version "1.8.0_181"
OpenJDK Runtime Environment (IcedTea 3.9.0) (build 1.8.0_181-b13 suse-27.1-x86_64)
OpenJDK 64-Bit Server VM (build 25.181-b13, mixed mode)

#### Start a hub
java -jar selenium-server-standalone-3.9.1.jar -role hub -cleanUpCycle 5000 -timeout 30 

#### Start a node
java -jar selenium-server-standalone-3.9.1.jar -role node  -hub http://localhost:4444/grid/register -timeout 30 -maxSession 5
#######################################################################################################

driver = webdriver.Remote(
   command_executor='http://127.0.0.1:4444/wd/hub',
   desired_capabilities={'browserName': 'firefox', 'javascriptEnabled': True})

#### headless and custom options for Chrome in grid
chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument('headless')
chrome_options.add_argument('window-size=1920x1080')
capabilities = {'browserName': 'chrome', 'javascriptEnabled': True}
capabilities.update(chrome_options.to_capabilities())
drv_chrome = webdriver.Remote(command_executor = 'http://192.168.122.60:4444/wd/hub', desired_capabilities = capabilities)

# OPTIONS
# cleanUpCycle is the time the grid waits before polling if any session is timed out. It is in milliseconds
# timeout is the time in seconds the the grid will allow a session to sit without any new commands that come to it
java -jar selenium-server-standalone-3.9.1.jar -role hub -role hub -cleanUpCycle 5000 -timeout 60
