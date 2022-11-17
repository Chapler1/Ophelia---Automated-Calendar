package com.example.demo;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicLong;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin
@RestController
public class OpheliaAPI {

    ArrayList<Project> projectList = new ArrayList<Project>();
    User exampleUser = new User();

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
/*    public String greeting(@RequestParam(value = "name", defaultValue = "World") String name) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode projectJson = mapper.readTree(exampleUser.getProjectList());
        return exampleUser.getProjectList();
    }*/
}
