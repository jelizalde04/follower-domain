package com.ms.follower.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import java.time.LocalDateTime;

@Entity
public class Follower {

    @Id
    private Long id;

    @ManyToOne
    private User follower;

    @ManyToOne
    private User followed;

    private LocalDateTime followDate;

    // Getters and Setters
}
