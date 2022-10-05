# Ophelia
CS1635 Project/Reoccurring task planner app with google calendar integration.
### Group Members:
- Cameron Nicholson
- Sean Shmulevich
- William Chapler
- Opeyemi Sanni


___
- <h1><a href="https://docs.google.com/document/d/1RFyngT-M6zcHdIN8o71TNi3WqWU-kVsYHzmeFXxLN3Y/edit">Deliverable 0</a></h1>
  - Discusses general app plan and general description of users of the app
- <h1><a href="https://docs.google.com/presentation/d/1nmNfW_MpaunoF-vFupPI1xJbjUCSXYqzJROpoPPIT4M/edit#slide=id.p">Deliverable 1</a></h1>
  - Detailed personas and storyboard for planning screens and app functionality
___
## Wireframe
- 🟥Red arrows are screen that link back to the Home Screen usually after finishing completing an action
- 🟩Green arrows link back and fourth between the Home Screen.
- ⬛️Black arrows are always "local" one screen jump
![WireframeAll](https://github.com/Sean-Shmulevich/Ophelia/blob/main/.images/WireframeAll.png)

## There are 5 major sections to complete as follows:
___
## 1.  Create account
- Create a new account or account already exists and go to home screen
- Configure hours when you sleep &amp; hours when you dont want the app to schedule your <span style="color:red">*"freetime"*</span>
- Confirmation screen when you finish configuring new account.
![WireframeMakeAcct](https://github.com/Sean-Shmulevich/Ophelia/blob/main/.images/WireframeMakeAcct.png)

## 2.  Homescreen + Schedule navigator
- Single press day for week view
  - Single press day for hour by hour day view
- Access individual projects/tasks.
![WireframeMainNav](https://github.com/Sean-Shmulevich/Ophelia/blob/main/.images/WireframeMainNav.png)

## 3. View project/task
- View single task and configure project settings
![WireframeViewTask](https://github.com/Sean-Shmulevich/Ophelia/blob/main/.images/WireframeViewTask.png)

## 4. Create new project/task
- maybe: before setting new events be prompted to resync with google calenders this will avoid schedule conflits before they happen.
- Collect user information about their event to schedule. 
- Generate and show possible schedules within given paremeters
- Show individual schedules on single press possibly implement a calendar view as well.
  - Show confirmation on single press of 'set' button cancel button goes back to home screen
    - cancel button could possibly prompt to add this configuration to a list of unscheduled tasks that are acessable from settings to be planned later.
![WireframeMakeTask](https://github.com/Sean-Shmulevich/Ophelia/blob/main/.images/WireframeMakeTask.png)

## 5. Settings
- Configure FreeTime
- Configure Sleep
- Sync with google calendars 
  - upload events we planned to google calendars
  - or download new events from google calendars
  - or opt into sync with google calendars
- Turn on/off all notifications and timers
- Some kind of mission statement
- Logout
![WireframeSettings](https://github.com/Sean-Shmulevich/Ophelia/blob/main/.images/WireframeSettings.png)
___
# Discussing project structure
## 1. User Object
- User information
  - Gmail
  - User_id
- Events
  - Events planned by the system
  - Static events (Describe times a user cant be planned)
    - imported google calender events
    - sleep time
    - free time
  - Alternatively
    - Events planned by the system (occur randomly around static events and system events)
    - Static events (Describe times a user cant be planned)
      - imported google calender events (occur randomly)
    - System events
      - sleep time (reoccuring each day consistently)
      - free time. (reoccuring each week consistently)
## 1. Alternate User Object
- User information:
  - Gmail
  - User_id
  - sleep time (simple bounds of time 00:00am-00:00pm) dont stick this into events class its a pretty global thing.
- Events
    - Events planned by the system (occur randomly around static events and system events)
    - Static events (Describe times a user cant be planned)
      - imported google calender events (occur randomly)
    - System events
      - sleep time (reoccuring each day consistently)
      - free time. (reoccuring each week consistently)