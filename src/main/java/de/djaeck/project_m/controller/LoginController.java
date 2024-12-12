package de.djaeck.project_m.controller;

import de.djaeck.project_m.entity.User;
import de.djaeck.project_m.service.UserService;
import de.djaeck.project_m.service.JWTService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth/login")
public class LoginController {

    @Autowired
    private UserService userService;

    @Autowired
    private JWTService jwtService;

    @PostMapping
    public ResponseEntity<String> loginUser(@RequestBody User user) {
        User existingUser = userService.getUserByUsernameAndPassword(user.getId(), user.getPassword());

        if (existingUser != null) {
            // Generate a JWT token for the existing user
            String jwtToken = jwtService.generateToken(existingUser.getId());
            return new ResponseEntity<>(jwtToken, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Invalid username or password", HttpStatus.UNAUTHORIZED);
        }
    }
}