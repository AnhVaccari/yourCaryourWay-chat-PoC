package com.yourcaryourway.chat_backend.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.yourcaryourway.chat_backend.entitty.Message;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {
    List<Message> findByUserIdOrderByTimestampAsc(Long userId);

    List<Message> findAllByOrderByTimestampAsc();
}
