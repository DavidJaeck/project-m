package de.djaeck.project_m.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Entity
@Getter
@Setter
@Table(name = "app_user")  // Use a custom table name to avoid conflict with the reserved "user" keyword
public class User {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String email;
    private String phoneNumber;
    private String password;
    @Temporal(TemporalType.DATE)
    private Date dateOfBirth;
    private Boolean isActive = true;
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastLogin;
    private Boolean isVerified = false;
}
