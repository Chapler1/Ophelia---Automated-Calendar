package com.example.demo;
import java.time.Duration;
import java.time.LocalTime;


public class Event {
    //when the imported events events are init they are mapped to their days.
    //  it doesnt need a date bc it will be mapped to a day.
    LocalTime startTime;
    LocalTime endTime;
    //number of hours elapsed of an event
    double timeDelta;

    boolean hasTimes;
    //startTime - 430
    //endTime - 2130
    public Event(double timeDelta){
         hasTimes = false;
         this.timeDelta = timeDelta;
    }
    public Event(LocalTime startTime, LocalTime endTime){
        this.startTime = startTime;
        this.endTime = endTime;

        //kind of janky solution maybe this should be a different class??
        hasTimes = true;
        timeDelta = ((double)Duration.between(startTime, endTime).toMinutes())/60;
        //assert startMinutes <= 60
        //assert startHours <= 23
        //assert start comes before end.
        //length shouldn't be more than 23
        //range 1-2459

    }
    private static String addQuotes(String dateTime){
        char quote = '"';
        return quote + dateTime + quote;

    }
    public LocalTime getStartTime(){
        return startTime;
    }
    public LocalTime getEndTime(){
        return endTime;
    }
    public double getTimeDelta(){
        return timeDelta;
    }

    private static int uniqueName = 0;
    public String toString() {
        ++uniqueName;
        if(hasTimes){
            return String.format("{\"eventName\": \"%s\", \"startTime\": %s, \"endTime\": %s, \"timeDelta\": %f}", ("project #"+uniqueName), addQuotes(startTime.toString()), addQuotes(endTime.toString()), timeDelta);
        }
        else{
            return String.format("{\"eventName\": \"%s\", \"timeDelta\": %f }", ("project #"+uniqueName), timeDelta);
        }
    }

    //time displacement function.
}