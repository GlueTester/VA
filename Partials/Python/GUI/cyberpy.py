from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support.wait import WebDriverWait
import time

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


def obtain_cert():
    class Scraper:

        def __init__(self, headless: bool = True) -> None:

            #self.headless = headless

            pass

        def setup_scraper(self) -> None:
            profieldir = 'C:\\Users\\VHALEXKingR1\\AppData\\Local\\Google\\Chrome\\User'
            chromedir = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"
            chrome_user_data = "C:\\Users\\VHALEXKingR1\\AppData\\Local\\Google\\Chrome\\User Data"

            self.options = Options()

            #self.options.add_argument("--headless=new",) #https://www.selenium.dev/blog/2023/headless-is-going-away/

            self.options.add_experimental_option('excludeSwitches', ['enable-logging']) #https://stackoverflow.com/questions/47392423/python-selenium-devtools-listening-on-ws-127-0-0-1
            
            self.options.add_argument('log-level=3') #https://github.com/SeleniumHQ/selenium/issues/13095

            #self.options.set_capability("browserVersion", "117") #https://github.com/SeleniumHQ/selenium/issues/13095
            self.options.add_argument("--remote-debugging-port=8080") #Corrected Mule 1 not opeing port for chrome
            #self.options.add_argument(r"--user-data-dir=C:\Users\VHALEXKingR1\AppData\Local\Google\Chrome\User Data") #e.g. C:\Users\VHALEXKingR1\AppData\Local\Google\Chrome\User Data
            #self.options.add_argument(r'--profile-directory=C:\Users\VHALEXKingR1\AppData\Local\Google\Chrome\User') #e.g. Profile 3
            self.driver = webdriver.Chrome(options=self.options)
            self.options.add_experimental_option("prefs", {"profile.managed_default_content_settings.images": 2}) 
            self.options.add_argument("--no-sandbox") 
            self.options.add_argument("--disable-setuid-sandbox") 
            self.options.add_argument("--disable-dev-shm-using") 
            self.options.add_argument("--disable-extensions") 
            self.options.add_argument("--disable-gpu") 
            self.options.add_argument("start-maximized") 
            self.options.add_argument("disable-infobars")
            self.options.add_argument(r"user-data-dir=.\cookies\\test")
            self.options.add_experimental_option("detach", True) #https://stackoverflow.com/questions/74466414/how-to-stop-browser-closing-in-python-selenium-without-calling-quit-or-close
            #self.options.add_argument(r"user-data-dir=C:\Users\VHALEXKingR1\AppData\Local\Google\Chrome\User Data")
            #self.options = webdriver.ChromeOptions()
            

            #self.driver = webdriver.Chrome(executable_path=r'C:\path\to\chromedriver.exe', chrome_options=options)


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

    #profieldir = 'C:\Users\VHALEXKingR1\AppData\Local\Google\Chrome\User'
    #chromedir = "C:\Program Files\Google\Chrome\Application\chrome.exe"
    #chrome_user_data = "C:\Users\VHALEXKingR1\AppData\Local\Google\Chrome\User Data"
    #https://stackoverflow.com/questions/52394408/how-to-use-chrome-profile-in-selenium-webdriver-python-3

    scraper = Scraper()

    scraper.setup_scraper()

    scraper.navigate('https://vacrrwebcya311.aac.dva.va.gov/PasswordVault/v10/logon?returnUrl=%2F')

    #self.logbox.insert('end', f"{timestamp}    {program_name} - At CyberArc page: Please wait\n")
    #self.update() 

    #Some vars
    
    sleeptime = 2

    #Go to webpage and ensure it scisco 
    time.sleep(sleeptime)
    single_element = scraper.driver.find_element(By.XPATH,"/html/body/shell-app/span/login-form/div/div/header/img")#grabs title in page

   
    continue_button_xpath = '//*[@id="continue-button"]/span'
    PIV_button_xpath = "/html/body/shell-app/span/login-form/div/div/main/div[2]/div/login-auth-select/login-carousel/div/div/ul/li[2]/div/button/div/div[1]/span"
    account_view_xpath = "/html/body/pv-app/span/div/pv-accounts-actions-manager/pv-accounts/cyb-page-layout/div/pv-accounts-header/cyb-header/cyb-base-header/div[1]/div/h1"
    adminname_xpath = "/html/body/pv-app/span/div/pv-accounts-actions-manager/pv-accounts/cyb-page-layout/div/pv-accounts-splitter/cyb-splitter/div/div[1]/pv-accounts-grid/cyb-server-data-table/div[1]/ag-grid-angular/div/div[2]/div[1]/div[3]/div[2]/div/div/div[2]/div[2]/cyb-text-col/span"
    admin0Iname_xpath = "/html/body/pv-app/span/div/pv-accounts-actions-manager/pv-accounts/cyb-page-layout/div/pv-accounts-splitter/cyb-splitter/div/div[1]/pv-accounts-grid/cyb-server-data-table/div[1]/ag-grid-angular/div/div[2]/div[1]/div[3]/div[2]/div/div/div[1]/div[2]/cyb-text-col/span" 
    clickedaccount_copypass_xpath = "/html/body/pv-app/span/div/pv-accounts-actions-manager/pv-accounts/cyb-page-layout/div/pv-accounts-splitter/cyb-splitter/div/div[2]/div[2]/cyb-selected-item-details/div/cyb-selected-item-details-header/div/div[2]/cyb-more-items-trigger-action-menu/cyb-floating-container/div/div[2]/button/span" 
    

    WebDriverWait(scraper.driver, 20).until(EC.presence_of_element_located((By.XPATH , continue_button_xpath))) #Wait for Continue button
    time.sleep(sleeptime)
    scraper.driver.find_element(By.XPATH , continue_button_xpath ).click() #Click Continue button
    
    WebDriverWait(scraper.driver, 20).until(EC.presence_of_element_located((By.XPATH , PIV_button_xpath)))# Wait for PIV Button
    time.sleep(sleeptime)
    scraper.driver.find_element(By.XPATH , PIV_button_xpath).click() #Click PIV Button

    #WebDriverWait(scraper.driver, 40).until(EC.presence_of_element_located((By.XPATH , account_view_xpath)))# Wait for account name to be viewable
    WebDriverWait(scraper.driver, 20).until(EC.presence_of_element_located((By.XPATH , adminname_xpath))) #Wait for admin name to be visable
    time.sleep(sleeptime)
    scraper.driver.find_element(By.XPATH , adminname_xpath).click() #Click admin name
    time.sleep(sleeptime)
    WebDriverWait(scraper.driver, 20).until(EC.presence_of_element_located((By.XPATH , clickedaccount_copypass_xpath))) #wait for copy button to appear
    time.sleep(sleeptime)
    scraper.driver.find_element(By.XPATH , clickedaccount_copypass_xpath).click() #Click copy



    #scraper.navigate('https://vhalexfonucm01.v09.med.va.gov/ccmadmin/phoneFindList.do') #here we are only search by what the filter are by defualt (Device Name. starts with)
    #time.sleep(sleeptime)
    
    #scraper.driver.find_element(By.XPATH , PIV_button_xpath).click() # Click PIV Button
    #time.sleep(sleeptime) 
    #scraper.input("searchString0",searchitem )
    #time.sleep(sleeptime)
    #scraper.driver.find_element(By.XPATH,"/html/body/shell-app/span/login-form/div/div/header/img").click()
    #time.sleep(sleeptime)
    #last_resistered = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(8)').text
    #device_Name_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(3) > a').text
    #device_description_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(4)').text
    #device_status_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(7)').text
    #device_IP_line = scraper.driver.find_element(By.CSS_SELECTOR,'#phoneFindListForm > table.cuesTableBg > tbody > tr.cuesTableRowEven > td:nth-child(11)').text


    #self.LastRegistered_Text.configure(text = last_resistered)
    #self.PhoneStatus_Text.configure(text = device_status_line)
    #self.DeviceName_Text.configure(text = device_Name_line)
    #self.Description_Text.configure(text = device_description_line) 
    #self.Phone_IPV4_Text.configure(text = device_IP_line)
obtain_cert()