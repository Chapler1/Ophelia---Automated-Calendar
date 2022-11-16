package com.example.demo;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
public class Calendar{
    ArrayList<Day> dayList = new ArrayList<Day>();
    public Calendar(){
        //init new calendar starting from today going until next year.
        LocalDate today = LocalDate.now();
        LocalDate tomorrow;
        for(int i = 0; i < 365; i++){
            tomorrow = today.plusDays(1);

            Day newD = new Day(today);
//            System.out.println(today.toString());
            newD.addEvent(new Event(10));
            dayList.add(newD);
            today = tomorrow;
        }
    }
    public ArrayList<Day> getDayList(){
        return dayList;
    }
    public String toString(){
        String result = String.format("\"calendar\": {%s ", dayList.get(0).toString());
        for(int i = 1; i < dayList.size(); i++){
            result += dayList.get(i).toString();
        }
        result += "}";
        return result;
    }
//    ArrayList<Day> getWeek(int weekNum) {}
//    ArrayList<Day> getMonth(int monthNum) {}
}

