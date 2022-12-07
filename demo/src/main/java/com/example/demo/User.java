package com.example.demo;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import java.io.IOException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class User {
    Event[] filledBlocksWeek = new Event[7];//freetime user option
    Event sleep;
    ArrayList<Project> projectList = new ArrayList<Project>();
    ArrayList<Event> importedEvents = new ArrayList<Event>();
    Calendar userCal;

    public User(Event[] filledBlocksWeek, Event sleep, ArrayList<Project> projectList, ArrayList<Event> importedEvents, Calendar userCal) {
        this.filledBlocksWeek = filledBlocksWeek;
        this.sleep = sleep;
        projectList.add(new Project());
        this.userCal = userCal;
    }

    public User(){
        LocalTime l1 = LocalTime.of(10,43,12);
        LocalTime l2 = LocalTime.of(11,43,12);

        LocalTime l3 = LocalTime.of(10,43,12);
        LocalTime l4 = LocalTime.of(20,43,12);

        LocalTime l5 = LocalTime.of(10,43,12);
        LocalTime l6 = LocalTime.of(15,43,12);

        LocalTime l7 = LocalTime.of(9,43,12);
        LocalTime l8 = LocalTime.of(10,43,12);

        LocalTime l9 = LocalTime.of(6,43,12);
        LocalTime l10 = LocalTime.of(10,43,12);

        LocalTime l11 = LocalTime.of(6,43,12);
        LocalTime l12 = LocalTime.of(15,43,12);

        LocalTime l13 = LocalTime.of(20,43,12);
        LocalTime l14 = LocalTime.of(21,43,12);

        Event[] blockedOutTimesWeekly = new Event[]{new Event(l1,l2), new Event(l3,l4), new Event(l5,l6), new Event(l7,l8), new Event(l9,l10), new Event(l11,l12), new Event(l13,l14)};
        LocalTime sleepStart = LocalTime.of(23,0,12);
        LocalTime sleepEnd = LocalTime.of(8,43,12);

        filledBlocksWeek = blockedOutTimesWeekly;
        sleep = new Event(sleepStart, sleepEnd);
        Project p1 = new Project();
        Project p2 = new Project();
        Project p3 = new Project();
        
        p1.setProjectIndex(0);
        p2.setProjectIndex(1);
        p3.setProjectIndex(2);
        // projectList.add(p1);
        // projectList.add(p2);
        // projectList.add(p3);
        userCal = new Calendar();
    }

    public Event getSleep() {
        return sleep;
    }
    public Event[] getBlockedWeeklyTimes(){
        return filledBlocksWeek;
    }
    public String getFullProjectJson() {
        String toReturn = String.format("[%s", projectList.get(0).toString());
        for (int i = 1; i < projectList.size(); i++) {
            toReturn += String.format(",%s",projectList.get(i).toString());
        }
        toReturn += "]";
        return toReturn;
    }
    public String getProjectNames(){
        //!! repeated code here 3x in this file basically
        if(projectList.size() == 0){
            return "noProjects";
        }
        String toReturn = String.format("[{\"0\": \"%s\", \"projectColor\": \"%s\"}", projectList.get(0).getName(), projectList.get(0).getColor());
        for (int i = 1; i < projectList.size(); i++) {
            toReturn += String.format(",{\"%d\": \"%s\", \"projectColor\": \"%s\"}",i, projectList.get(i).getName(),  projectList.get(i).getColor());
        }
        toReturn += "]";
        return toReturn;
    }
    public ArrayList<Project> getProjectList() {
        return projectList;
    }
    public Calendar getCalendar() {
        return userCal;
    }

//    public JsonNode getnode() throws Exception {
//        ObjectMapper mapper = new ObjectMapper();
//        JsonNode node = mapper.createObjectNode();
//        ObjectNode rootNode = (ObjectNode)node;
//        rootNode.put("sleep", sleep.toString());
//        ObjectNode weekBlock = rootNode.putObject("breakTime");
//        ObjectNode projects = rootNode.putObject("projects");
//
//        for (int i = 0; i < filledBlocksWeek.length; i++) {
//            weekBlock.putObject(String.valueOf(mapper.readTree(filledBlocksWeek[i].toString())));
//        }
//        for (int i = 0; i < projectList.size(); i++) {
//            projects.putObject(String.valueOf(mapper.readTree(projectList.get(i).toString())));
//        }
//        System.out.println(node);
//        return node;
//    }

    public String toString() {
        String toReturn = String.format("{\"sleep\": {%s}, \"breakTime\": {%s",sleep.toString(), filledBlocksWeek[0].toString());
        for (int i = 1; i < filledBlocksWeek.length; i++) {
            toReturn += String.format(",%s",filledBlocksWeek[i].toString());
        }
        //TODO: important case to catch here!!!.
        toReturn += String.format("}, \"projectList\": {%s", projectList.get(0).toString());
        for (int i = 1; i < projectList.size(); i++) {
            toReturn += String.format(",%s",projectList.get(i).toString());
        }
        toReturn += String.format("}}", userCal.toString());
        return toReturn;
    }

    //functions
    //deletes a project
//    public void deleteProject(User x, Project p){}
//    //deletes a user
//    public void deleteUser(User x){}
//    //changes a user's reoccuring events
//    public void changeReEvents(User x){}
//    //clears a user's calendar
//    public void clearCalendar(User x){}

}