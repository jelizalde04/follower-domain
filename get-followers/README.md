
# Get-Followers Microservice 

## 1. Service Overview

The **get-followers** service retrieves all followers for a given pet. It queries the `followers` table and returns a list of follower relationships.

---

## 2. Routes and Endpoints

### Get Followers

```http
GET /api/v1/followers?petId=<uuid>
```

Response Example:

```json
{
  "message": "Followers retrieved successfully",
  "data": [
    {
      "id": "uuid",
      "followerId": "uuid",
      "petId": "uuid",
      "createdAt": "2025-06-27T18:10:00Z"
    }
  ]
}
```

---

## 3. How the Service Works

1. Validates JWT token.
2. Checks that the pet belongs to the authenticated user.
3. Queries the database for all follower relationships.

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
- Confirms the pet ownership for security.

---

## 6. Setup and Execution

### Environment Variables

- `DATABASE_URL`
- `JWT_SECRET`

### Run with Docker

```bash
docker build -t get-followers .
docker run -p 7003:7003 get-followers
```

---

## 7. Swagger Documentation

Available at:

```
http://localhost:7003/api-docs
```

---

## 8. Testing and Coverage

Tests written in RSpec.

Run tests:

```bash
bundle exec rspec
```

---

## 9. Contributing

Fork → Branch → Pull Request.
