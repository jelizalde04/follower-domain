# Follower Microservice with WebHook – Spring Boot + Swagger

This project is a microservice developed in Java with Spring Boot, designed to manage the action of following (giving "follow") between users. When a user follows another, a notification is sent to another system via a WebHook.

## Key Features

- Exposes a REST endpoint (`POST /followers`) to register a new follower.
- Verifies that the user has not already followed the same profile.
- Registers the follow relationship in a many-to-many table.
- Sends a WebHook notification to another service when a user follows another.
- Uses Swagger UI for interactive documentation and API testing.

## `/followers` Endpoint Flow

### Request

**Method:** `POST`

**URL:** `/followers`

**Request Body:**

```json
{
  "followedId": 123
}


### Successful Response (201 Created)
{
    "message": "User successfully followed.",
    "status": 201
}

### Error Response (400 Bad Request)
{
    "message": "The user already follows this profile.",
    "status": 400
}

### Swagger Path

    The path to access the interactive Swagger documentation is:

        http://localhost:6001/api-docs-followers