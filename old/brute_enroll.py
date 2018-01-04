from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time

driver = webdriver.Chrome()
#driver = webdriver.phantomjs()
#driver=webdriver.phantomjs.webdriver.WebDriver()
driver.get("http://my.ucalgary.ca")

#if(driver.title "Central Authentication Service"){
euser = driver.find_element_by_id("eidtext")
epass = driver.find_element_by_id("passwordtext")
euser.send_keys("scott.saunders")
epass.send_keys("swukA8H9!")
epass.send_keys(Keys.ENTER)
#}

#goto enroll page
driver.get("https://csprd.ucalgary.ca/psc/csprd/STUDENT/CAMPUS/c/SA_LEARNER_SERVICES.SSR_SSENRL_CART.GBL?Page=SSR_SSENRL_CART&Action=A&ACAD_CAREER=UGRD&EMPLID=10163541&ENRL_REQUEST_ID=&INSTITUTION=UCALG&STRM=2167")

#Proceed
elem = driver.find_element_by_id("DERIVED_REGFRM1_LINK_ADD_ENRL$82$")
elem.click() 

#Finish
elem=driver.find_element_by_id("DERIVED_REGFRM1_SSR_PB_SUBMIT")
elem.click()
driver.close()

