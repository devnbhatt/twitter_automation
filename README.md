### Introduction
This Repository has the code to do the twitter login functionality automation.
This uses Python and Robot Framework with selenium for that.

### Setup
Please use attached requirement.txt for installing required package.
use below mentioned command for required package installation 

pip install -r requirements.txt

### How to Use
Give below mentioned command in command prompt/terminal.

General Command :

robot -v email:{your email} -v password:{your password} -v userName:{user name of profile} -v mobile:{registered mobile with account} login_page.robot

Note : userName and mobile number just need to be given if twitter blocks the login saying unusual activity. so either userName or mobile number needs to be provided.

If you are specifying only userName then use below mentioned command :

robot -v email:{your email} -v password:{your password} -v userName:{user name of profile} login_page.robot

If you are specifying only mobile then use below mentioned command :

robot -v email:{your email} -v password:{your password} -v mobile:{registered mobile number with account} login_page.robot
