package de.djaeck.project_m.controller;

import de.djaeck.project_m.entity.User;
import de.djaeck.project_m.service.UserService;
import de.djaeck.project_m.service.JWTService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth/register")  // Use /auth/register endpoint for registration
public class RegistrationController {

    @Autowired
    private UserService userService;

    @Autowired
    private JWTService jwtService;  // Inject JwtService for JWT generation

    @PostMapping
    public ResponseEntity<String> registerUser(@RequestBody User user) {
        // Call the userService to save the user (registration logic)
        User createdUser = userService.addUser(user);

        if (createdUser != null) {
            // Generate a JWT token for the new user
            String jwtToken = jwtService.generateToken(createdUser.getId());

            // Return the JWT token as part of the response
            return new ResponseEntity<>(jwtToken, HttpStatus.CREATED);
        } else {
            // If the user creation failed, return an error response
            return new ResponseEntity<>("User registration failed", HttpStatus.BAD_REQUEST);
        }
    }
}
