package com.example.follower.service;

import com.example.follower.model.Follower;
import com.example.follower.model.User;
import com.example.follower.repository.FollowerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class FollowerService {

    @Autowired
    private FollowerRepository followerRepository;

    public Follower followUser(User follower, User followed) throws Exception {
        if (followerRepository.existsByFollowerAndFollowed(follower, followed)) {
            throw new Exception("El usuario ya sigue a este perfil.");
        }

        Follower newFollower = new Follower();
        newFollower.setFollower(follower);
        newFollower.setFollowed(followed);
        newFollower.setFollowDate(LocalDateTime.now());

        return followerRepository.save(newFollower);
    }
}
