# Installing and setup of Selenium Grid on Linux


#######################################################################################################
# openSuse Leap 42.3 # installed with Java development pkgs
# download jar file from http://selenium-release.storage.googleapis.com/index.html

mstan@grid-suse:~> java -version
openjdk version "1.8.0_181"
OpenJDK Runtime Environment (IcedTea 3.9.0) (build 1.8.0_181-b13 suse-27.1-x86_64)
OpenJDK 64-Bit Server VM (build 25.181-b13, mixed mode)

#### Start a hub
java -jar selenium-server-standalone-3.9.1.jar -role hub

#### Start a node
java -jar selenium-server-standalone-3.9.1.jar -role node  -hub http://localhost:4444/grid/register
#######################################################################################################

driver = webdriver.Remote(
   command_executor='http://127.0.0.1:4444/wd/hub',
   desired_capabilities={'browserName': 'firefox', 'javascriptEnabled': True})
