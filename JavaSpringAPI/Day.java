package com.example.demo;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;

class Day
{
    int numFreeHours = 24;
    LocalDate date;
    ArrayList<Event> eventList = new ArrayList<Event>();//list of all events schedules for that day.
    public Day(LocalDate date){
        this.date = date;
    }
    public int getFreeHours(){
        return numFreeHours;
    }
    public void setFreeHours(int freeHours){
        //make sure it's not negative
        this.numFreeHours = freeHours;
    }
    public ArrayList<Event> getEventList(){
        return eventList;
    }
    public void addEvent(Event event) {
        eventList.add(event);
    }
    public String toString(){
        String dayJson = String.format("\"date\": %s {\"freeHours\": %s, \"eventList\": {%s", date.toString(), numFreeHours, eventList.get(0));
        //I am starting at one here to avoid the trailing comma it actually not a bad way to do it.
        for(int i=1; i<eventList.size(); i++){
            Event e = eventList.get(i);
            dayJson += String.format(",%s",e.toString());
        }
        dayJson+="}}";
        return dayJson;
    }
}