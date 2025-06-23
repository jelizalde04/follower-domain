package com.example.follower.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class WebhookService {

    public void sendWebhook(String url, Object data) {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.postForObject(url, data, String.class);
    }
}
