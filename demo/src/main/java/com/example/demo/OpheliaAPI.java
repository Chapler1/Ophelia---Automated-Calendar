package com.example.demo;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicLong;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin
@RestController
public class OpheliaAPI {

    ArrayList<Project> projectList = new ArrayList<Project>();
    User exampleUser = new User();

    int numProjects = 2;

    @CrossOrigin
    @GetMapping("/getProjectNames")
    public JsonNode getPName() throws Exception /*json parse exception*/ {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode projectJson = mapper.readTree(exampleUser.getProjectNames());
        return projectJson;
    }

    @CrossOrigin
    @GetMapping("/getFullProjectJson")
    public JsonNode getProj() throws Exception /*json parse exception*/ {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode projectJson = mapper.readTree(exampleUser.getFullProjectJson());
        return projectJson;
    }

    @CrossOrigin
    @GetMapping("/getUserCalendar")
    public JsonNode getUserCal() throws Exception /*json parse exception*/ {
        ///List of stuff and i need to know what.
        ObjectMapper mapper = new ObjectMapper();
        JsonNode projectJson = mapper.readTree(exampleUser.getFullProjectJson());
        return projectJson;
    }
    @CrossOrigin
    @GetMapping("/getProject")
    public JsonNode getUserProject(@RequestParam(value = "id", defaultValue="0")  String id) throws Exception /*json parse exception*/ {
        ///List of stuff and i need to know what.
        ObjectMapper mapper = new ObjectMapper();
        String project = exampleUser.getProjectList().get(Integer.valueOf(id)).toString();
        JsonNode projectJson = mapper.readTree(project);
        return projectJson;
    }

    @GetMapping("/addProject")
    public String addProject() throws Exception /*json parse exception*/ {
        ///List of stuff and i need to know what.
        ObjectMapper mapper = new ObjectMapper();
        exampleUser.getProjectList().add(new Project ());
        return "project added to user";
    }

    //make a post mapping
    @PostMapping("/planProject")
    public String planProject(@RequestBody String message) throws Exception /*json parse exception*/{
        ObjectMapper mapper = new ObjectMapper();
        JsonNode projectJson = mapper.readTree(message);
        String projectName = projectJson.get("projectName").textValue();
        System.out.println(projectName);
        String projectDeadline = projectJson.get("projectDeadline").textValue();
        int numSessions = Integer.parseInt(projectJson.get("numSessions").textValue());
        int numHours = Integer.parseInt(projectJson.get("numHours").textValue());



        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
        //string to date
        LocalDate deadline = LocalDate.parse(projectDeadline, dateTimeFormatter);

        Project newProj = new Project(LocalDate.now(), deadline, projectName, exampleUser, numSessions, numHours);
        
        System.out.println(projectJson.get("projectName"));
        newProj.setProjectIndex(numProjects);
        numProjects++;
        exampleUser.projectList.add(newProj);
        return newProj.toString();
    }  
    
/*    public String greeting(@RequestParam(value = "name", defaultValue = "World") String name) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode projectJson = mapper.readTree(exampleUser.getProjectList());
        return exampleUser.getProjectList();
    }*/
}
