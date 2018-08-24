#Orgional author: Scott Saunders, 2017.
# I guess a BSD license... just do whatever, it's a double while loop in selenium.

##Origonally used to brute-force enrollment into classes without waitlists.
## Basically, given your username/password, it logins, and goes to current(or more probably, winter2018)'s class schedule, and enrolls with anything you have there. If somebody happens to have left the class, you now get in!

#Note: Most of the ID's for find_element_by_id() will probably change over time, but if you do the steps manually, and record the ID's via right-clicking them, insepct element, and finding the < id="foobar" >, you can update them as needed. (This happens every semester)

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
        
        #sign-in
        username=sys.argv[1]
        password=sys.argv[2]
        driver.find_element_by_id("eidtext").send_keys(username)
        driver.find_element_by_id("passwordtext").send_keys(password)
        driver.find_element_by_id("signinbutton").submit()

        time.sleep(2)
        driver.get("https://csprd.my.ucalgary.ca/psc/csprd/EMPLOYEE/SA/c/SA_LEARNER_SERVICES.SSS_STUDENT_CENTER.GBL")
        driver.find_element_by_id("DERIVED_SSS_SCR_SSS_LINK_ANCHOR2").click()
        
        #While loop of enrolling classes.
        while True:
            #Internal Iframe of the resulting url.
            
        
            driver.find_element_by_id("DERIVED_REGFRM1_LINK_ADD_ENRL$82$").click()
            driver.find_element_by_id("DERIVED_REGFRM1_SSR_PB_SUBMIT").click()
            
#            time.sleep(2) #Unknown if actually needed, but here for safety.
            driver.find_element_by_id("DERIVED_REGFRM1_SSR_LINK_STARTOVER").click()
    finally:
        print("relogging in")

