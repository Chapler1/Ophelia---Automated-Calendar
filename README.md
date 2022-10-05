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
  - Drag between times to set times you do not want to be scheduled for projects in a per hour view of an entire generic week from monday-sunday
- Confirmation screen when you finish configuring new account.
![WireframeMakeAcct](https://github.com/Sean-Shmulevich/Ophelia/blob/main/.images/WireframeMakeAcct.png)

## 2.  Homescreen + Schedule navigator
- Single press day for week view
  - Single press day for hour by hour day view
- Access individual projects/tasks.
![WireframeMainNav](https://github.com/Sean-Shmulevich/Ophelia/blob/main/.images/WireframeMainNav.png)

## 3. View project/task
- the main view of scheduled events in this screen should very similar to the generated schedule -> pick schedule view
  - i.e. - the request of class should be the same 
  -( `list projectX = project.getListOfTimes()`Union `list otherThings = projectX.forEach(projectSessionDateTime => User.calendar.get(projectSessionDateTime)`) == set of times on this screen.
- View single task and configure project settings
- should this view be able to show everything thats happening on each individual day with a project scheduled or should it just show the times of each scheduled session
  - what if there are two sessions scheduled for one day?
- include other long term events/projects in this view or only imported google calendar events?
![WireframeViewTask](https://github.com/Sean-Shmulevich/Ophelia/blob/main/.images/WireframeViewTask.png)

## 4. Create new project/task
- Collect user information about their event to schedule. 
- Generate and show possible schedules within given paremeters
- Show individual schedules on single press possibly implement a calendar view as well.
  - Show confirmation on single press of 'set' button cancel button goes back to home screen
    - cancel button could possibly prompt to add this configuration to a list of unscheduled tasks that are acessable from settings to be planned later.
- Maybe?
  - maybe: before setting new events be prompted to resync with google calenders this will avoid schedule conflits before they happen. but it may mess up an existing one :/
  - Maybe add the option to add a link to a git repo or canvas or something
  - Maybe add the option checkbox to schedule on weekends (override free time)
  - Represent schedule with relative size of 7 rectangles representing relative time per day scheduled. 
  - What if no schedules could be make?
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

- lets say we implement automatic google calender sync:
-  this is a solution to some problems
   -  but what if a user schedules an event during another event through google calender and then comes back to the app. 
      -  how will the system know that this happened?
      -  how will will it react.
         -  one option is to prompt reschedule - too much work
         -  make the event 15 minutes after the event it has a conflict with - this is good but we should tell the user it was rescheduled
![WireframeSettings](https://github.com/Sean-Shmulevich/Ophelia/blob/main/.images/WireframeSettings.png)
___
# Discussing project structure


### Requirements of the system
- you need to be able to get a list of all projects/tasts scheduled by the system: 
  - this is Events minus freetime minus sleep minus google calender events
- need to be able to get a week in a month and each event/task scheduled by the system as well as google calender imported tasks
  - this is (Events - freetime - sleep) within a given week
- need to be able to get each day and all events assoicated with that day
  - this is also (Events - freetime - sleep) for a given day.
- Need to be able to get one project/task individually and find all other scheduled events on those days
  - this is (allEvents - freetime - sleep) for the set of days given by the scheduled days of the specific project/task

### considerations 
- The user should probably have some kind of calender object of events. freetime and sleep should not be planned into it
- A project also def needs a class
  - the project class has a list of times and days that are scheduled
- the system needs a list of all days including freetime and sleep in order to schedule
  - should this exist or just be programatically done in a method of the user. probably the latter
- could have a global calendar object per user that expresses the set of all days and you schedule events onto the global calendar this calendar ignores sleep and "freeTime"
  - this is redundant no? days can be plotted out into a calendar.
- to view the schedule suggestion generated for a given projectX
  -  `list projectX = project.getListOfTimes()`Union`list otherThings = projectX.forEach(projectSessionDateTime => User.getEventsAtDay(projectSessionDateTime)`
    - what if we wanted to subtract the other projects from this view 
      -  `list projectX = project.getListOfTimes()`Union `list otherThings = projectX.forEach(projectSessionDateTime => User.getFixedEvents(projectSessionDateTime)`

## 1. Object structures + reasoning
- User
  - static user information
    - Gmail
    - User_id
    - One dateless time object that expresses a range of time that the user is sleeping.
  - Projects list of projects each project is basically a DateTime list
  - list of events possibly/likely multiple per day that express freeTime when you dont want to be scheduled. this is an event list but the events have no names and stuff.
  - imported google calendar events list.
- ... other stuff ... 

  - there might be a problem with organizing it with many different lists. 
    - if we need to find all information from one specific date event if its a tree then its N_lists * log(n) the 'N' lists will be fixed(3 or 4) so itll still be O(log(n)) but it'll be worse
    - solution is to keep a global list of google_calendar_events + all_projects which will be lit this will be called and be a class (nah imo) or it'll just be a generic list of events that will be a variable called calendar. 
    - also keep individual lists.
    - And if you want to show a view without other projects in it then you just search through the fixed event list(google cal imports) not the calendar. this will be fast nice.
      - for expandability add the option to add more types of fixed events to plan around in the code. 
        - for example reoccuring fixed events we wont implement it but how can we make a nice space for it.
        - but how would you then get all of the fixed events independently. reoccuring and single time imports.???????
          - when you would add a reoccuring event it would iterate out into all days and times in a given year it would be scheduled for and it would add its generic event to the calendar
- Project
  - ???

- Event
  - ???

### all info below is not super relevant but theres some good stuff
___
- User information
  - Gmail
  - User_id
- Events
  - Events planned by the system (these have a specific day in the year and specific time)
  - Static events (Describe times a user cant be planned)
    - imported google calender events (these have a specific day in the year and specific time)
    - sleep time (this is one time for all days)
    - free time (this is 7 times for each day for all days in a year)
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