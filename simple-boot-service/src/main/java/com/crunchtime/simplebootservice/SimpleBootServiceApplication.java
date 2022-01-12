package com.crunchtime.simplebootservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.Random;

@SpringBootApplication
@RestController
public class SimpleBootServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(SimpleBootServiceApplication.class, args);
	}

	@GetMapping("/api/number")
	public Integer getRandomInteger(){
		Random random = new Random();
		return random.nextInt(10000);
	}
	
	@GetMapping("/api/echo/{str}")
	public Object getRandomInteger(@PathVariable("str") Object data){
		return data;
	}
}
