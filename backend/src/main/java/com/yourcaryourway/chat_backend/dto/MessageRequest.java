package com.yourcaryourway.chat_backend.dto;

import lombok.Data;

@Data
public class MessageRequest {
    private Long userId;
    private String content;
}
