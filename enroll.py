import time
import sys
from selenium import webdriver

if len(sys.argv) != 3:
    print("Unknown username/password")
    sys.exit()

#driver=webdriver.Firefox()
#driver=webdriver.PhantomJS()
driver=webdriver.Chrome()

driver.implicitly_wait(10) 

while True:
    try:
        #driver.get("http://my.ucalgary.ca")
        driver.get("https://cas.ucalgary.ca/cas/login?service=https://portal.my.ucalgary.ca/psp/paprd/?cmd=start&ca.ucalgary.authent.ucid=true")
        
        #time.sleep(1)
        
        username=sys.argv[1]
        password=sys.argv[2]
        driver.find_element_by_id("eidtext").send_keys(username)
        driver.find_element_by_id("passwordtext").send_keys(password)
        driver.find_element_by_id("signinbutton").submit()
        
        time.sleep(2)
        
        while True:
            #Internal Iframe of the resulting url.
            driver.get("https://csprd.my.ucalgary.ca/psc/csprd/EMPLOYEE/SA/c/SA_LEARNER_SERVICES.SSS_STUDENT_CENTER.GBL")
        
            driver.find_element_by_id("DERIVED_SSS_SCR_SSS_LINK_ANCHOR2").click()
            driver.find_element_by_id("DERIVED_REGFRM1_LINK_ADD_ENRL$82$").click()
            driver.find_element_by_id("DERIVED_REGFRM1_SSR_PB_SUBMIT").click()
            time.sleep(2) #Unknown if actually needed, but here for safety.
    finally:
        print("relogging in")

