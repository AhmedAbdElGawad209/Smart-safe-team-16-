﻿

# Smart safe 


Our project aims to upgrad the level of security, smartness and efficiency of normal safe.

### A description of what the project is for.


 #### Our project aims to upgrad the level of security, smartness and efficiency of normal safe.
 
* **the idea of our team is** to build a smart safe which is connect to a mobile with a password and then 
can be remotely acessed by number of users with a permisssion of the owner. 
when an owner first use the project it will connect to the safe using blutooth and write the password for the safe 
then it is time for the members which they ineed for acessing the safe without the prensence of the owner to open the safe.
for the sake of  achieving this the owner give the members an ID which can identify the member. 
if the member insert it ID the safe will send a massage to the owner with the ID. 
owner has the choice to accept and then the safe open 
OR reject and then the safe stay locked and a rejection alarm is set . 
if the ID is not correct an alarm is set to warn from a robbing trial.  

**The safe also contins anti move system :**
     It has light sensor which sens if the safe is moved from its regular place setting alarm and warning the owner by massage.
     
## Hardware elements of the project   
**the safe has :**  


-  **AVR ATMEGA32**
-  **Rlay** which control the electrical  lock of the safe.   
-  **keypad** which users use to insert their IDs.   
-  **LDR** sensor in the bottom of the safe to sens the motion of the safe.    
-  **LDR** sensor inside the safe facing the door to sens if the door is closed or open.  
-  **LEDs&Buzzer** to get palpable response of the safe different modes.   
         
 ## Safe response to different modes :
 ### Connetion-less mode :
 when the safe is not connected to any owner . 
 -       Red LED is ON
 ![](https://github.com/AhmedAbdElGawad209/Smart-safe-team-7-/blob/master/connection%20less%20mode.jpg)
         
  ### Connetion mode :
  when the safe owner connect to the safe and enter his password. 
  -     All LEDs (red, yellow, blue) are ON.
 ![](https://github.com/AhmedAbdElGawad209/Smart-safe-team-7-/blob/master/connection%20mode.jpg)
 ### Rejection mode  :
 when a member enter his right ID but the owner reject his request. 
  -      Red LED is ON and  buzzer is ON (discrete noise) 
 ![](https://github.com/AhmedAbdElGawad209/Smart-safe-team-7-/blob/master/rejection%20mode.jpg)
 ### Robbing mode  :
 when an unknown person enter wrong ID or the owner enter wrong password. 
  -      Red LED is ON and the buzzer is on (more long discrete noise) 
 ![](https://github.com/AhmedAbdElGawad209/Smart-safe-team-7-/blob/master/connection%20less%20mode.jpg)
 ### Open mode :
  when a member enter correct ID and the owner accept hi request . 
  -     yellow LED is ON, buzzer is ON  and safe is open. 
 ![](https://github.com/AhmedAbdElGawad209/Smart-safe-team-7-/blob/master/rightID%26%20allowance.jpg)
 ### Moving mode  :
 when someone try to move the safe from its palce  . 
 -        All LEDs (red, yellow, blue) are ON and the buzzer is on (contious discrete noise)
 ![](https://github.com/AhmedAbdElGawad209/Smart-safe-team-7-/blob/master/moving.jpg)
 
  
        
  
 **Who will use this repo or project?** 
        Anyone who want to enhace his safe smartness.
               * it could be a family members who are all ineed to acess the safe.
               * A job group or team who want to save a very secure papar of work 
                  ,but still easily acessed among the team.     

### Proteus Design 
![alt text](https://github.com/AhmedAbdElGawad209/Smart-safe-team-7-/blob/master/proteus%20Design.jpg
)

### Instructions for how to  use the project.

users can immediately strat with our project by downloading a mobile application from  [here](https://play.google.com/store/apps/details?id=project.bluetoothterminal&hl=ar&gl=US) 
,connet to the safe, set their users ID and then they ready to go.







### For any truoble using the project kindly connect our team at:
- safe98067@gmail.com


###  © 2021 Smart safe team 

- [ِAhmed Mohamed Mahmoud AbdElgawad](https://github.com/AhmedAbdElGawad209)
- [Ahmed Gamal Elshahat](https://github.com/ahmedgamala)
- [Aya Mohamed Amin](https://github.com/Aya292Muhammed)
- [Doaa Abo-sriaa Abd-Atty](https://github.com/doaaabusriaa)
- [Sara Ashraf Elsayed](https://github.com/sara-ashraf2022)

