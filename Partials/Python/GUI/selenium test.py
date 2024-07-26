from selenium import webdriver

from selenium.webdriver.chrome.options import Options

from selenium.webdriver.common.by import By

from selenium.webdriver.remote.webelement import WebElement

import time

class Scraper:

   def __init__(self, headless: bool = True) -> None:

       self.headless = headless

       pass

   def setup_scraper(self) -> None:

       self.options = Options()

       self.options.add_argument("--headless=new",) #https://www.selenium.dev/blog/2023/headless-is-going-away/

       self.options.add_experimental_option('excludeSwitches', ['enable-logging']) #https://stackoverflow.com/questions/47392423/python-selenium-devtools-listening-on-ws-127-0-0-1
       
       self.options.add_argument('log-level=3') #https://github.com/SeleniumHQ/selenium/issues/13095

       #self.options.set_capability("browserVersion", "117") #https://github.com/SeleniumHQ/selenium/issues/13095

       self.driver = webdriver.Chrome(options=self.options)

   def navigate(self, target) -> None:

       self.driver.get(target) if target else print('[!] No target given. Please specify a URL.')

   def extract_raw_data(self) -> str:

       return self.driver.page_source

   def extract_single_element(self,  selector: str, selector_type: By = By.CSS_SELECTOR) -> WebElement:

      return self.driver.find_element(selector_type, selector)

   def extract_all_elements(self, selector: str, selector_type: By = By.CSS_SELECTOR) -> list[WebElement]:

       return self.driver.find_elements(selector_type, selector)
   
   def input(self, field, keystosend) -> None:
       
       return self.driver.find_element(By.NAME, field).send_keys(keystosend)
   
   def get_screenshot(self, filename)-> None:
       
       return self.driver.get_screenshot_as_file(filename)
   
   def click_single_element(self,  selector: str, selector_type: By = By.CSS_SELECTOR) -> WebElement:

       return self.driver.find_element(selector_type, selector).click()

# Initialize a new Scraper and navigate to a target

scraper = Scraper()

scraper.setup_scraper()

scraper.navigate('https://vhalexfonucm01.v09.med.va.gov/ccmadmin/showHome.do')

# Extract and print the entire HTML document

#raw_data = scraper.extract_raw_data()

searchitem  = "CFSVHALEXFeistT"

#print(raw_data)

# Extract and print an element by its class name

single_element = scraper.extract_single_element('cuesLoginProductName', By.CLASS_NAME) #grabs title in page

print(single_element.text)

# Extract and print all elements belonging to a tag type

#all_elements = scraper.extract_all_elements('a', By.TAG_NAME)

#print([el.get_attribute('href') for el in all_elements])

#<table cellspacing="0" width="100%" class="cuesTableBg" border="0" summary="Find List Table Result"><tbody><tr class="cuesTableBg"><th id="check" align="absmiddle"><input value="true" class="content-nogroove" name="masterCheckBox" onclick="selectNamedRowsCheckbox(this)" type="checkbox"></th><th id="Icon" width="10%">&nbsp;</th><th id="Device Name(Line)" align="left"><a id="sortId" href="javascript:onColumnFindSubmit(&quot;name&quot;,&quot;false&quot;)" class="cuesToolbarLink"><span class="cuesTableColumnHeaderSorted">Device Name(Line)<img alt="Sort Descending" src="/ccmadmin/themes/VtgBlaf/SortAscending16.gif"></span></a></th><th id="Description" align="left"><a href="javascript:onColumnFindSubmit(&quot;description&quot;,&quot;true&quot;)" class="cuesToolbarLink">Description</a></th><th id="Device Pool" align="left"><a href="javascript:onColumnFindSubmit(&quot;DevicePoolName&quot;,&quot;true&quot;)" class="cuesToolbarLink">Device Pool</a></th><th id="Device Protocol" align="left"><a href="javascript:onColumnFindSubmit(&quot;TypeDeviceProtocolName&quot;,&quot;true&quot;)" class="cuesToolbarLink">Device Protocol</a></th><th id="findlist.heading.status">Status</th><th id="phone.heading.lastseen">Last Registered</th><th id="phone.heading.lastactive">Last Active</th><th id="phone.heading.nodeid">Unified CM</th><th id="findlist.heading.ipaddressipv4">IPv4 Address</th><th id="findlist.heading.copy">Copy</th><th id="findlist.heading.supercopy">Super Copy</th></tr><tr class="cuesTableRowEven"><td headers="check" align="center"><input value="true" class="content-nogroove" name="result[0].chked" type="checkbox"><input name="result[0].col[0].stringVal" type="hidden" value="263dc69a-9389-bb96-505c-ab2a5b8d38b6"><input name="result[0].col[1].stringVal" type="hidden" value="CFSVHALEXFeistT"></td><td align="left" id="icon7" headers="Icon" nowrap="nowrap"><a href="gendeviceEdit.do?key=263dc69a-9389-bb96-505c-ab2a5b8d38b6" class="cuesTextLink"><img title="Cisco Unified Client Services Framework" class="content-grid-button-image" alt="Cisco Unified Client Services Framework" src="/ccmadmin/images/product390.gif"></a></td><td headers="Device Name(Line)" align="left"><a href="gendeviceEdit.do?key=263dc69a-9389-bb96-505c-ab2a5b8d38b6" class="cuesTextLink">CFSVHALEXFeistT</a></td><td headers="Description" align="left">LEX; SOUSLEY; FIS ACCT; ; ; ; ; ;</td><td headers="Device Pool" align="left"><a href="devicePoolEdit.do?key=07882520-3e47-d3c0-0546-f25b7469612c" class="cuesTextLink">dpLEX-Leestown-ODD</a></td><td headers="Device Protocol" align="left">SIP</td><td headers="findlist.heading.status" align="left">Unregistered</td><td headers="Last Registered" align="left">Jul 25, 2024 3:12:36 PM</td><td headers="Last Active" align="left"></td><td headers="Unified CM" align="left">vhalexfonucm03</td><td headers="findlist.heading.ipaddressipv4" align="left">10.239.195.116</td><td headers="findlist.heading.copy" align="left"><a href="gendeviceEdit.do?clone=1&amp;key=263dc69a-9389-bb96-505c-ab2a5b8d38b6" class="cuesTextLink"><img alt="Copy" title="Copy" src="/ccmadmin/themes/VtgBlaf/Copy16.gif"></a></td><td headers="findlist.heading.supercopy" align="left"><a href="superCopyEdit.do?clone=1&amp;key=263dc69a-9389-bb96-505c-ab2a5b8d38b6" class="cuesTextLink"><img alt="Super Copy" title="Super Copy" src="/ccmadmin/themes/VtgBlaf/SuperCopy16.gif"></a></td></tr></tbody></table>


#Some vars
username="OITLEXKINGR10"
password="lockdown00"


#Go to webpage and ensure it scisco 
call_manager_page_header = scraper.extract_single_element('cuesLoginProductName', By.CLASS_NAME) #grabs title in page

#log into page
scraper.input("j_username",username )
scraper.input("j_password",password )
scraper.driver.find_element(By.XPATH,"/html/body/form/div[2]/table[1]/tbody/tr[1]/td[2]/table/tbody/tr[5]/td/button[1]").click() #Login button, used Full XPATH becuase couldnt get other to work #Source 1.https://www.selenium.dev/documentation/webdriver/elements/locators/ | 2.https://stackoverflow.com/questions/65657539/how-to-located-selenium-element-by-css-selector

#ensure we are logged in
headertext_user = scraper.extract_single_element("cuesHeaderText", By.CLASS_NAME)

if (headertext_user.text != username):  #.text has to be added becuase element was being retun not its content
    print (f"Logged in user is:{headertext_user.text}  but the username provide is:{username}")
else:
    scraper.navigate('https://vhalexfonucm01.v09.med.va.gov/ccmadmin/phoneFindList.do') #here we are only search by what the filter are by defualt (Device Name. starts with)
    scraper.input("searchString0",searchitem )
    #scraper.click_single_element("findButton")
    scraper.driver.find_element(By.XPATH,"/html/body/table/tbody/tr/td/div/form[1]/div/table/tbody/tr[1]/td[7]/input").click()
    last_resistered = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(8)').text
    device_Name_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(3) > a').text
    device_description_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(4)').text
    device_status_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(7)').text
    device_IP_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(11)').text


    #phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(8)
    print (f"Last Registered:{last_resistered}")
    print (f"Device Name:{device_Name_line}")
    print (f"Decription:{device_description_line}")
    print (f"Status:{device_status_line}")
    print (f"IPV4:{device_IP_line}")
