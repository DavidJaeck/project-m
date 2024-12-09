package de.djaeck.project_m.service;

import de.djaeck.project_m.entity.User;
import de.djaeck.project_m.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    // Add a new user
    public User addUser(User user) {
        return userRepository.save(user); // Save the user to the database
    }
}
