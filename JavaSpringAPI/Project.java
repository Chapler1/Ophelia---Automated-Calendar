package com.example.demo;

import java.time.LocalTime;
import java.util.ArrayList;
import java.time.LocalDate;
import java.util.Random;
public class Project  {

    //user input options...
    LocalDate startDate;
    LocalDate deadline;

    String projectName;
    int projectColor;
    int numSessions;
    int numHours;
    String projectNotes;
    User user;
    //list of days and time deltas.
    ArrayList<DateEvent> projectList = new ArrayList<DateEvent>();

    public Project(LocalDate startDate, LocalDate deadline, String projectName, User user, int numSessions, int numHours)
    {
        this.startDate = startDate;
        this.deadline = deadline;
        this.projectName = projectName;
        this.user = user;
        this.numSessions = numSessions;
        this.numHours = numHours;
        ///set list of days 'projectList'
        this.projectList = distributeProject();
    }
    //creates a dummy project with given data.
    public Project(){
        projectName = "sample Project";
        projectColor = 0;
        LocalDate today = LocalDate.now();
        startDate = today;
        deadline = today.plusDays(10);

        numSessions = 10;
        numHours = 20;
        projectNotes = "hello world project notes";

        //10 2 hours sessions on 10 days.
        Random rand = new Random();
        LocalDate curr = today;
        for(int i = 0; i < numSessions; i++){
            int random_hour = rand.nextInt(20);
            int random_minute = rand.nextInt(59);

            LocalTime startTime = LocalTime.of(random_hour,random_minute,0);
            LocalTime endTime = LocalTime.of(random_hour+2,random_minute,0);
            curr = curr.plusDays(1);
            DateEvent dateEvent = new DateEvent(startTime,endTime, curr);
            projectList.add(dateEvent);
        }
    }

    public ArrayList<DateEvent> distributeProject() {
        ArrayList<DateEvent> eventList = new ArrayList<DateEvent>();

        int startCount = 0;
        while (!user.userCal.dayList.get(startCount).date.equals(startDate)) startCount++;

        int deadCount = startCount;
        while (!user.userCal.dayList.get(deadCount).date.equals(deadline)) deadCount++;

        //Find all free days between startDate and deadline (where numFreeHours > numHours) 
        //Find the most free days (need at least numSessions)
        //Starts at 24 hours free, loops down until hours < numHours
        //If conditions not met, return null (can be replaced with message to frontend)
        ArrayList<Day> freeDays = new ArrayList<Day>();
        for (int i = 24; i > numHours; i--){
            ArrayList<Day> temp = new ArrayList<Day>();
        
            for (int j = startCount; j < deadCount - 1; j++){
                if (user.userCal.dayList.get(j).getFreeHours() > i) temp.add(user.userCal.dayList.get(j));
            }       
            //if number of free days > numSessions, accept
            //System.out.println("temp.size(): " + temp.size());
            if ((temp.size() >= numSessions) && (freeDays.size() == 0)) freeDays = temp;
        }
        //So now we have an array list of the most free days between the startDate and deadline

        //Not enough free time, so we fail (should be replaced with error message in front end)
        if (freeDays.size() == 0){ 
            System.out.println("PROJECT DISTRIBUTION FAILED: NOT ENOUGH FREE DAYS");
            return null;
        }

        //Spreading the events out evenly across the most free days (in freeDays)
        System.out.println("freeDays.size(): " + freeDays.size());
        int eventsBooked = 0;
        for (double dayIndex = 0; eventsBooked < numSessions; dayIndex += ((double)freeDays.size() / (double)numSessions)) {
            int intDayIndex = (int) dayIndex;
            DateEvent event = new DateEvent(LocalTime.of(0,0,0), LocalTime.of(numHours,0,0), freeDays.get(intDayIndex).date);
            eventsBooked++;
            eventList.add(event); //add to projects eventList
            freeDays.get(intDayIndex).getEventList().add(event); //add to Day's eventList
            freeDays.get(intDayIndex).setFreeHours(freeDays.get(intDayIndex).getFreeHours() - numHours); //subtracting numHours from the day's numFreeHours
        }

        return eventList;
    }

    public String getName() {
        return projectName;
    }

    public String toString(){
        String toReturn = String.format("{\"projectName\": \"%s\", \"projectColor\": %s, \"numSessions\": %s, \"numHours\": %s, \"projectNotes\": \"%s\", \"startDate\":\"%s\", \"endDate\": \"%s\", \"projectDays\": [%s",
                projectName, projectColor, numSessions, numHours, projectNotes, startDate.toString(), deadline.toString(), projectList.get(1));
        for(int i = 1; i < projectList.size(); i++){
            toReturn += String.format(",%s",projectList.get(i).toString());
        }
        toReturn += "]}";
        return toReturn;
    }
}