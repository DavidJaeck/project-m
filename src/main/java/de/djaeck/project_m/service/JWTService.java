package de.djaeck.project_m.service;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Service;
import java.util.Date;
@Service
public class JWTService {

    private final String SECRET_KEY = "passwordpasswordpasswordpasswordpasswordpassword";  // You should store this securely, e.g., in environment variables

    // Generate JWT token for a given user (e.g., id)
    public String generateToken(long id) {
        long expirationTime = 1000 * 60 * 60 * 10;  // 10 hours

        return Jwts.builder()
                .setSubject(String.valueOf(id))  // Set the id
                .setIssuedAt(new Date())  // Set the issue date
                .setExpiration(new Date(System.currentTimeMillis() + expirationTime))  // Set expiration time
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)  // Sign the JWT
                .compact();  // Create the JWT token
    }

    // Extract the id from the JWT token
    public long extractId(String token) {
        String idStr = Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
        return Long.parseLong(idStr);
    }

    // Check if the JWT is expired
    public boolean isTokenExpired(String token) {
        Date expirationDate = Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody()
                .getExpiration();
        return expirationDate.before(new Date());  // Return true if expired
    }

    // Validate the JWT token
    public boolean validateToken(String token, long id) {
        long extractedId = extractId(token);
        return (id == extractedId && !isTokenExpired(token));  // Validate both id and expiration
    }
}