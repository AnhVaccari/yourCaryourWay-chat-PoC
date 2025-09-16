package com.yourcaryourway.chat_backend.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.yourcaryourway.chat_backend.entitty.Role;
import com.yourcaryourway.chat_backend.entitty.User;
import com.yourcaryourway.chat_backend.repository.UserRepository;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Override
    public void run(String... args) throws Exception {
        // Insérer utilisateurs de test seulement si la table est vide
        if (userRepository.count() == 0) {
            User client = new User("client@test.com", Role.CLIENT);
            User conseiller = new User("conseiller@test.com", Role.CONSEILLER);

            userRepository.save(client);
            userRepository.save(conseiller);

        }
    }
}
