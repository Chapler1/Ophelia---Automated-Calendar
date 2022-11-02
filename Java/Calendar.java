package Java;
import java.util.*;

public abstract class Day{
    int numFreeHours = 24;
    Date date;
    ArrayList<Event> eventList = new ArrayList<Event>();

}

public abstract class Event {
    //when the imported events events are init they are mapped to their days.
    //  it doesnt need a date bc it will be mapped to a day. 
    int hours;
    String name;
    Day day;

}

public abstract class reoccuringEvents {
    //Contains 7 lists of reoccuring events (one for each day)
     ArrayList<ArrayList<Event>> week = new ArrayList<ArrayList<Event>>();

     for (int i = 0; i < 7; i++){
        week.add(new ArrayList<Event>());
     }

}

public class Project{
    String name;
    String event;
    String desc;
    //user input options...
    Date startDate;
    Date dueDate;

    //list of events (days where you work on the project)
    ArrayList<Event> eventList = new ArrayList<Event>();
    
	//function to distribute project to multiple events
	public void buildEvents(Project p){}
}


public abstract class User {
    reoccuringEvents reEvents;
    ArrayList<Project> projectList = new ArrayList<Project>();
    ArrayList<Event> importedEvents = new ArrayList<Event>();
    Calendar userCal;
	
	//functions
	//deletes a project
	public void deleteProject(User x, Project p){}
	//deletes a user
	public void deleteUser(User x){}
	//changes a user's reoccuring events
	public void changeReEvents(User x){}
	//clears a user's calendar
	public void clearCalendar(User x){}

}

public abstract class Calendar{
    ArrayList<Day> dayList = new ArrayList<Day>();
    public ArrayList<Day> getWeek(int weekNum) {}
    public ArrayList<Day> getMonth(int monthNum) {}
    public ArrayList<Day> buildYear(ArrayList<Day> dayList){} 
}



