package com.com.follower.controller;

import com.example.follower.model.User;
import com.example.follower.service.FollowerService;
import com.example.follower.service.WebhookService;
import com.example.follower.util.JwtUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(value = "Followers Management", tags = "Followers")
@RestController
@RequestMapping("/followers")
public class FollowerController {

    @Autowired
    private FollowerService followerService;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private WebhookService webhookService;

    @ApiOperation(value = "Follow a user", notes = "Permite que un usuario siga a otro")
    @PostMapping
    public String followUser(@RequestHeader("Authorization") String token, @RequestBody User followed) throws Exception {
        // Extrae el usuario autenticado desde el token JWT
        String username = jwtUtil.extractUsername(token);
        User follower = new User();
        follower.setUsername(username); // Suponiendo que tienes el nombre de usuario en el JWT

        // Realiza el seguimiento
        followerService.followUser(follower, followed);

        // Llama al WebHook para notificar al otro sistema
        webhookService.sendWebhook("http://another-system-url.com/webhook", followed);

        return "User followed successfully!";
    }
}
