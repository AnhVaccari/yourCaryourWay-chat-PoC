package com.yourcaryourway.chat_backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.yourcaryourway.chat_backend.dto.MessageRequest;
import com.yourcaryourway.chat_backend.entitty.Message;
import com.yourcaryourway.chat_backend.repository.MessageRepository;

@Controller
public class ChatController {

    @Autowired
    private MessageRepository messageRepository;

    @MessageMapping("/sendMessage") // Reçois les messages sur "/app/sendMessage"
    @SendTo("/topic/messages")
    public Message sendMessage(MessageRequest request) {
        // Sauvegarde en base de données
        Message message = new Message(request.getUserId(), request.getContent());
        Message savedMessage = messageRepository.save(message);

        // Diffuse automatiquement à tous les clients connectés
        return savedMessage;
    }
}
