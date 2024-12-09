package de.djaeck.project_m;

import de.djaeck.project_m.entity.User;
import de.djaeck.project_m.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping
    public List<User> getAllUsers() {
        return userService.getAllUsers();
    }

    // Add a new user
    @PostMapping
    public ResponseEntity<User> addUser(@RequestBody User user) {
        // The userService will handle the logic for adding the user.
        User createdUser = userService.addUser(user);
        return new ResponseEntity<>(createdUser, HttpStatus.CREATED);
    }
}
