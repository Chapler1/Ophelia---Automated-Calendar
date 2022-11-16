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
    //list of days and time deltas.
    ArrayList<DateEvent> projectList = new ArrayList<DateEvent>();

    public Project(LocalDate startDate, LocalDate deadline, String projectName)
    {
        this.startDate = startDate;
        this.deadline = deadline;
        this.projectName = projectName;
        ///set list of days 'projectList'
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