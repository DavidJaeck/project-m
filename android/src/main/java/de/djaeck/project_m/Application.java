package de.djaeck.project_m;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "de.djaeck.project_m")  // Add this line
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}

