package de.djaeck.project_m.repository;

import de.djaeck.project_m.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findById(long id);

    Optional<User> findByIdAndPassword(long id, String password);
}
