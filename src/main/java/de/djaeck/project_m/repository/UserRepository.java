package de.djaeck.project_m.repository;

import de.djaeck.project_m.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
}
