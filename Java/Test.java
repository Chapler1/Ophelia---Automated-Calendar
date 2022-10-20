package Java;
import java.util.*;
public class Test
{
    public static void main(String[] args)
    {
        
    }
}

abstract class Day
{
    int numFreeHours = 24;
    Date date;
    ArrayList<Project> projectList = new ArrayList<Project>();//list of projects scheduled for that day. 
    ArrayList<Event> importedEvents = new ArrayList<Event>();//list of all imported events on that day

}

interface Event {
    //when the imported events events are init they are mapped to their days.
    //  it doesnt need a date bc it will be mapped to a day. 
    int getStartTime();
    int getEndTime();
    int getTimeDelta();

    //time displacement function.
}
class ImportedEvents implements Event{
    int startTime;
    int endTime;
    Day day;
    ImportedEvents(int startTime, int endTime, Day day)
    {
        this.startTime = startTime;
        this.endTime = endTime;
        this.day = day;
    }
    public int getStartTime()
    {
        return startTime;
    }
    public int getEndTime()
    {
        return endTime;
    }
    public int getTimeDelta()
    {
        return endTime - startTime;
    }
}

class Project  {
    int startTime;
    int endTime;
    String projectName;
    String projectNotes;
    //user input options...
    Date startDate;
    Date endDate;

    ArrayList<Day> projectList = new ArrayList<Day>();
    Project(Date startDate, Date endDate, String projectName)
    {
        this.startDate = startDate;
        this.endDate = endDate;
        this.projectName = projectName;
        ///set list of days 'projectList'
    }
}


abstract class User {
    Event[] filledBlocksWeek = new Event[7];//freetime user option
    Event sleep;
    ArrayList<Project> projectList = new ArrayList<Project>();
    ArrayList<Event> importedEvents = new ArrayList<Event>();
    Calendar userCal;

}

abstract class Calendar{
    ArrayList<Day> dayList = new ArrayList<Day>();
    ArrayList<Day> getWeek(int weekNum) {}
    ArrayList<Day> getMonth(int monthNum) {}
}



