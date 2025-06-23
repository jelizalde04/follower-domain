package com.ms.follower.repository;

import com.example.follower.model.Follower;
import com.example.follower.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FollowerRepository extends JpaRepository<Follower, Long> {
    boolean existsByFollowerAndFollowed(User follower, User followed);
}
