# Remove-Follower Microservice 

## 1. Service Overview

The **remove-follower** service deletes "follow" relationships between pets. It allows a pet to unfollow another pet by removing the relationship from the `followers` table.

---

## 2. Routes and Endpoints

### Delete Follower

```http
DELETE /api/v1/followers
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
  "message": "Follow deleted successfully"
}
```

---

## 3. How the Service Works

1. Validates the JWT token.
2. Searches for the follower relationship.
3. Deletes the record if it exists.
4. Returns a 404 if the relationship is not found.

---

## 4. Technologies Used

- Ruby 3.2+
- Rails 8.x API
- PostgreSQL
- JWT
- Rswag for Swagger documentation

---

## 5. Authentication and Security

- JWT required for all endpoints.
- Confirms that the pet belongs to the authenticated user.

---

## 6. Setup and Execution

### Environment Variables

- `DATABASE_URL`
- `JWT_SECRET`

### Run with Docker

```bash
docker build -t remove-follower .
docker run -p 7002:7002 remove-follower
```

---

## 7. Swagger Documentation

Available at:

```
http://localhost:7002/api-docs
```

---

## 8. Testing and Coverage

Tests are written in RSpec.

Run tests:

```bash
bundle exec rspec
```

---

## 9. Contributing

Fork → Branch → Pull Request.

