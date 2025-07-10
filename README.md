# Follower Domain 

## 1. Domain Overview

The **Follower Domain** manages the follower relationships between pets. It allows pets to follow or unfollow other pets and to query who they are following.

### Main Features:

- **Add Follower** – allows a pet to follow another pet.
- **Remove Follower** – allows a pet to unfollow another pet.
- **Get Followers** – retrieves the list of followers for a specific pet.

### Microservices Included:

- add-follower
- remove-follower
- get-followers

### Technologies Used:

- Ruby 3.2+
- Rails 8.x (API mode)
- PostgreSQL
- JWT (JSON Web Tokens) for authentication
- Swagger (rswag) for API documentation
- Docker for deployment
- (Planned) gRPC for communication with the Notification Service

---

## 2. Domain Folder Structure

```
follower-domain/
├── add-follower/
│   ├── app/
│   ├── config/
│   └── spec/
├── remove-follower/
│   ├── app/
│   ├── config/
│   └── spec/
├── get-followers/
│   ├── app/
│   ├── config/
│   └── spec/
└── docker-compose.yml
```

- **add-follower/** → Handles creating follower relationships.
- **remove-follower/** → Handles removing follower relationships.
- **get-followers/** → Handles querying followers of a pet.
- **docker-compose.yml** → Configuration for running all services and databases locally.

---

## 3. Technologies Used

- Ruby
- Rails API
- PostgreSQL
- JWT for authentication
- Swagger (rswag) for documentation
- Docker
- gRPC (planned)

Microservices communicate only through database relationships and JWT authentication. They remain decoupled for scalability and maintainability.

---

## 4. Domain Workflow

### General Flow

1. **Authentication**
   - Each request passes through a middleware that validates the JWT token.
   - Ensures that the pet performing actions belongs to the authenticated user.

2. **Operations**
   - Add Follower → Creates a relationship in the `followers` table.
   - Remove Follower → Deletes the relationship from the table.
   - Get Followers → Returns followers for a specific pet.

3. **(Future) Notifications**
   - Adding a follower will trigger a gRPC call to the Notification Service.

---

## 5. Routes and Endpoints

### Add Follower

```http
POST /api/v1/followers
```

Request:

```json
{
  "followerId": "uuid",
  "petId": "uuid"
}
```

Response (201):

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

### Remove Follower

```http
DELETE /api/v1/followers
```

Request:

```json
{
  "followerId": "uuid",
  "petId": "uuid"
}
```

Response (200):

```json
{
  "message": "Follow deleted successfully"
}
```

### Get Followers

```http
GET /api/v1/followers?petId=<uuid>
```

Response (200):

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

## 6. Setup and Execution

### Requirements

- Docker
- PostgreSQL

### Run with Docker Compose

```bash
docker-compose up --build
```

### Run Individually

```bash
cd add-follower
docker build -t add-follower .
docker run -p 7001:7001 add-follower
```

### Environment variables:

- `DATABASE_URL`
- `JWT_SECRET`

---

## 7. Authentication and Security
- All routes require JWT tokens.
- The token contains the userId.
- Verifies the pet belongs to the authenticated user.
- Implements CORS protection.

---

## 8. Swagger Documentation

Each microservice provides interactive Swagger documentation:

- http://localhost:7001/api-docs → add-follower
- http://localhost:7002/api-docs → remove-follower
- http://localhost:7003/api-docs → get-followers

---

## 9. Contributing

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Submit a Pull Request.



