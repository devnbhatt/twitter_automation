*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Twitter Homepage
Suite Teardown    Close Browser

*** Variables ***
${twitterUrl}    https://twitter.com
${loginBtnOnHome}    //*[@id="react-root"]/div/div/div[2]/main/div/div/div[1]/div[1]/div/div[3]/div[5]/a/div
${inputEmail}    //*[@id="layers"]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div/div/div/div[5]/label/div/div[2]/div/input
${nextButton}    //*[@id="layers"]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div/div/div/div[6]/div
${passwordField}    //*[@id="layers"]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div[1]/div/div/div[3]/div/label/div/div[2]/div[1]/input
${signinButton}    //*[@id="layers"]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div[2]/div/div[1]/div/div/div/div
${enterUserCredential}    //*[@id="layers"]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div[1]/div/div[2]/label/div/div[2]/div/input
${nextStep}    //*[@id="layers"]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div[2]/div/div/div/div
${accounts}    //*[@id="react-root"]/div/div/div[2]/header/div/div/div/div[2]/div/div/div/div/div[2]/div/div[2]/div/div/div[4]/div
${logoutBtn}    //*[@id="layers"]/div[2]/div/div/div[2]/div/div[2]/div/div/div/div/div/a[2]/div[1]/div/span
${confirmLogout}    //*[@id="layers"]/div[2]/div/div/div/div/div/div[2]/div[2]/div[2]/div[1]/div/span/span
${unusualActivityMsg}    "There was unusual login activity on your account"
${twitterHome}    Join Twitter today.
${signInTwitter}    Sign in to Twitter

*** Keywords ***
Open Twitter Homepage
    Open Browser    ${twitterUrl}    ${browser}
    ${status}    Run Keyword and Return Status    Wait Until Page Contains    ${twitterHome}    30
    Run Keyword If    '${status}'=='False'    Open Twitter Homepage

*** Test Case ***
Perform Login
	[Tags]    TC_01
    # Check if login button visible or not and click if visible
    ${loginBtnStatus}    Run Keyword and Return Status    Wait Until Page Contains Element    ${loginBtnOnHome}    15
    Run Keyword If    '${loginBtnStatus}' == 'True'    Click Element    ${loginBtnOnHome}

    # check if fields for entering credentials are visible or not and input credentials if all fields are getting visible
    ${emailInputStatus}    Run Keyword and Return Status    Wait Until Page Contains    ${signInTwitter}    30
    Run Keyword If    '${emailInputStatus}' == 'True'    Input Text    ${inputEmail}    ${email}
    Run Keyword If    '${emailInputStatus}' == 'True'    Run Keywords    Click Element    ${nextButton}    AND    Sleep    5
	
	# Check if Getting unusual activity screen
	${unusualActivityStatus}    Run Keyword and Return Status    Wait Until Page Contains    ${unusualActivityMsg}    5
	${mobileNumberStatus}    Run Keyword and Return Status    Should Not Be Empty    ${mobile}
	${userNameStatus}    Run Keyword and Return Status    Should Not Be Empty    ${userName}
	${enterCredential}    Set Variable If    '${userNameStatus}' == 'True'    ${userName}    ${mobile}
	
	# Enter Password and Do the login
	Run Keyword If    '${emailInputStatus}' == 'True'    Input Text    ${enterUserCredential}    ${enterCredential}
    Run Keyword If    '${emailInputStatus}' == 'True'    Run Keywords    Click Element    ${nextStep}    AND    Sleep    5
	${passwordInputStatus}    Run Keyword and Return Status    Wait Until Page Contains Element    ${passwordField}    15
    Run Keyword If    '${passwordInputStatus}' == 'True'    Input Password    ${passwordField}    ${password}
    Run Keyword If    '${passwordInputStatus}' == 'True'    Run Keywords    Click Element    ${signinButton}    AND    Sleep    15

    # check if profile gets opened or not after login
    ${profilePageStatus}    Run Keyword And Return Status    Location Should Be    ${twitterUrl}/home
    Run Keyword If    '${profilePageStatus}' == 'False'    Sleep    30s
    ${profilePageStatus}    Run Keyword If    '${profilePageStatus}' == 'False'    Run Keyword And Return Status    Location Should Be    ${twitterUrl}/home
    Run Keyword If    '${profilePageStatus}' == 'False'    FAIL    Twitter Login Unsuccessful

Perform Logout
	[Tags]    TC_02
	# Do the logout if logged in successfully
	Run Keyword If     '${PREV TEST STATUS}'=='FAIL'    Fail    Precondition Not Match
	${status}    Run Keyword and Return Status    Wait Until Page Contains Element    ${accounts}    15
	Run Keyword If    '${status}' == 'True'    Click Element    ${accounts}
	${status}    Run Keyword and Return Status    Wait Until Page Contains Element    ${logoutBtn}    15
	Run Keyword If    '${status}' == 'True'    Click Element    ${logoutBtn}
	${status}    Run Keyword and Return Status    Wait Until Page Contains Element    ${confirmLogout}    15
	Run Keyword If    '${status}' == 'True'    Click Element    ${confirmLogout}
	
	# Verify if logout successfully or not
    ${status}    Run Keyword and Return Status    Wait Until Page Contains    ${twitterHome}    30
	Run Keyword If    '${status}' == 'False'    FAIL    Homepage Not Visible.
