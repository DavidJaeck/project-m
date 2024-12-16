package de.djaeck.project_m.service;

import de.djaeck.project_m.entity.User;
import de.djaeck.project_m.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User addUser(User user) {
        return userRepository.save(user);
    }

    public User getUserById(long id) {
        Optional<User> optionalUser = userRepository.findById(id);
        return optionalUser.orElse(null);
    }

    public User getUserByIdAndPassword(long id, String password) {
        Optional<User> optionalUser = userRepository.findByIdAndPassword(id, password);
        return optionalUser.orElse(null);
    }
}