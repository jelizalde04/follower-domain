# Add-Follower Microservice

## 1. Service Overview

The **add-follower** service creates "follow" relationships between pets. It allows one pet to follow another and stores the relationship in the `followers` table.

- Interacts indirectly with other microservices via the database and JWT authentication.
- (Planned) Will publish events via gRPC to the Notification Service.

---

## 2. Routes and Endpoints

### Create Follower

```http
POST /api/v1/followers
```

Request Example:

```json
{
  "followerId": "uuid",
  "petId": "uuid"
}
```

Response Example:

```json
{
  "message": "Follow created successfully",
  "data": {
    "id": "uuid",
    "followerId": "uuid",
    "petId": "uuid",
    "createdAt": "2025-06-27T18:10:00Z"
  }
}
```

---

## 3. How the Service Works
1. Validates JWT token.
2. Checks that petId belongs to the authenticated user.
3. Prevents a pet from following itself.
4. Creates a new record in the followers table.
5. (Future) Publishes an event via gRPC.

---

## 4. Technologies Used

- Ruby 3.2+
- Rails 8.x API
- PostgreSQL
- JWT
- Rswag for Swagger documentation

---

## 5. Authentication and Security

- JWT required in all requests.
- Token must contain userId.
- Implemented in before_action :authenticate_request.

---

## 6. Setup and Execution

### Environment Variables

- `DATABASE_URL`
- `JWT_SECRET`

### Run with Docker

```bash
docker build -t add-follower .
docker run -p 7001:7001 add-follower
```

---

## 7. Swagger Documentation

Available at:

```
http://localhost:7001/api-docs
```

---

## 8. Testing and Coverage

Tests are written using RSpec.

Run tests:

```bash
bundle exec rspec
```

---

## 9. Contributing
Fork → Branch → Pull Request.