package com.example.demo;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.LocalDate;

public class DateEvent extends Event {
    LocalTime startTime;
    LocalTime endTime;
    LocalDate date;
    public DateEvent(LocalTime startTime, LocalTime endTime, LocalDate date)
    {
        super(startTime, endTime);
        this.date = date;
    }
    public DateEvent(double timeDelta, LocalDate date)
    {
        super(timeDelta);
        this.date = date;
    }
/*    public DateEvent(int timeDelta, String date)
    {
        super(timeDelta);
        try {
            DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            // you can change format of date
            Date dateObj = formatter.parse(date);
            timeStampDate = new Timestamp(dateObj.getTime());
        } catch (ParseException e) {
            System.out.println("Exception :" + e);
        }
    }*/
    public String toString(){
        String eventString = super.toString();
//        int firstWord = eventString.indexOf(" ");
        //removes last char from the string.
        String removeBrackets = eventString.substring(0, eventString.length() - 1);
        return String.format("%s, \"date\": "+'"'+"%s"+'"'+"}",removeBrackets, date.toString());
    }
    public String toString(int index){
        String eventString = super.toString(index);
//        int firstWord = eventString.indexOf(" ");
        //removes last char from the string.
        String removeBrackets = eventString.substring(0, eventString.length() - 1);
        return String.format("%s, \"date\": "+'"'+"%s"+'"'+"}",removeBrackets, date.toString());
    }
    public LocalDate getDate(){
        return date;
    }
}
