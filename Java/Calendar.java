package Java;
import java.util.*;

public abstract class Day{
    int numFreeHours = 24;
    Date date;
    ArrayList<Project> projectList = new ArrayList<Project>();
    //ArrayList<Event> importedEvents = new ArrayList<Event>();

}

public abstract class Event {
    //when the imported events events are init they are mapped to their days.
    //  it doesnt need a date bc it will be mapped to a day. 
    int startTime;
    int endTime;

    //time displacement function.
}

public abstract class Event1 extends Event {
    //when the imported events events are init they are mapped to their days.
    //  it doesnt need a date bc it will be mapped to a day. 
    int startTime;
    int endTime;
    Day d;
    //time displacement function.
}

public class Project extends Event1 {
    String projectName;
    String projectNotes;
    //user input options...
    Date startDate;
    Date endDate;

    ArrayList<Day> projectList = new ArrayList<Day>();
}


public abstract class User {
    Event[] filledBlocksWeek = new Event[7];//freetime user option
    Event sleep;
    ArrayList<Project> projectList = new ArrayList<Project>();
    ArrayList<Event> importedEvents = new ArrayList<Event>();
    Calendar userCal;

}

public abstract class Calendar{
    ArrayList<Day> dayList = new ArrayList<Day>();
    public ArrayList getWeek(int weekNum) {}
    public ArrayList getMonth(int monthNum) {}
}



