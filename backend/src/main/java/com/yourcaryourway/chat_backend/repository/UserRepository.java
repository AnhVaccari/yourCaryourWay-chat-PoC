package com.yourcaryourway.chat_backend.repository;

import com.yourcaryourway.chat_backend.entitty.Role;
import com.yourcaryourway.chat_backend.entitty.User;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);

    Optional<User> findByRole(Role role);
}
