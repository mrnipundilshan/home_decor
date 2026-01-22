# API Documentation

## Overview

This is the API documentation for the Home Decor Backend server. The API provides endpoints for user authentication, profile management, and product data retrieval.

**Base URL**: `http://localhost:3000`

All endpoints return JSON responses.

---

## Authentication

Most endpoints require authentication using JWT (JSON Web Tokens). The API uses a two-token system:

- **Access Token**: Short-lived token (15 minutes) used for API requests
- **Refresh Token**: Long-lived token (7 days) used to obtain new access tokens

### Using Access Tokens

Include the access token in the `Authorization` header of your requests:

```
Authorization: Bearer <access_token>
```

### Token Flow

1. User signs up and verifies OTP
2. User logs in to receive `accessToken` and `refreshToken`
3. Use `accessToken` for authenticated requests
4. When `accessToken` expires, use `refreshToken` to get a new `accessToken`

---

## Endpoints

### Authentication Endpoints

#### 1. Sign Up

Create a new user account.

**Endpoint**: `POST /api/signup`

**Authentication**: Not required

**Request Body**:

```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response** (201 Created):

```json
{
  "success": true,
  "otp": "123456",
  "message": "OTP sent to email"
}
```

**Error Responses**:

- **400 Bad Request**: Missing email or password

  ```json
  {
    "success": false,
    "error": "Email and password are required"
  }
  ```

- **400 Bad Request**: Invalid email format

  ```json
  {
    "success": false,
    "error": "Invalid email format"
  }
  ```

- **400 Bad Request**: Weak password

  ```json
  {
    "success": false,
    "error": "Password must be at least 6 characters long"
  }
  ```

- **409 Conflict**: User already exists
  ```json
  {
    "success": false,
    "error": "User with this email already exists"
  }
  ```

---

#### 2. Verify OTP

Verify the OTP sent during signup to activate the account.

**Endpoint**: `POST /api/verify-otp`

**Authentication**: Not required

**Request Body**:

```json
{
  "email": "user@example.com",
  "otp": "123456"
}
```

**Response** (200 OK):

```json
{
  "success": true,
  "message": "Account verified successfully"
}
```

**Error Responses**:

- **400 Bad Request**: Missing email or OTP

  ```json
  {
    "success": false,
    "error": "Email and OTP are required"
  }
  ```

- **404 Not Found**: User not found

  ```json
  {
    "success": false,
    "error": "User not found"
  }
  ```

- **400 Bad Request**: Account already verified

  ```json
  {
    "success": false,
    "error": "Account is already verified"
  }
  ```

- **400 Bad Request**: Invalid OTP

  ```json
  {
    "success": false,
    "error": "Invalid OTP"
  }
  ```

- **400 Bad Request**: OTP expired
  ```json
  {
    "success": false,
    "error": "OTP has expired. Please request a new one"
  }
  ```

---

#### 3. Login

Authenticate user and receive access tokens.

**Endpoint**: `POST /api/login`

**Authentication**: Not required

**Request Body**:

```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response** (200 OK):

```json
{
  "success": true,
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "email": "user@example.com"
  }
}
```

**Error Responses**:

- **400 Bad Request**: Missing email or password

  ```json
  {
    "success": false,
    "error": "Email and password are required"
  }
  ```

- **401 Unauthorized**: Invalid credentials

  ```json
  {
    "success": false,
    "error": "Invalid email or password"
  }
  ```

- **403 Forbidden**: Account not verified
  ```json
  {
    "success": false,
    "error": "Account not verified. Please verify your email first"
  }
  ```

---

#### 4. Refresh Token

Get a new access token using a refresh token.

**Endpoint**: `POST /api/refresh-token`

**Authentication**: Not required

**Request Body**:

```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response** (200 OK):

```json
{
  "success": true,
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Error Responses**:

- **400 Bad Request**: Missing refresh token

  ```json
  {
    "success": false,
    "error": "Refresh token is required"
  }
  ```

- **401 Unauthorized**: Invalid or expired refresh token
  ```json
  {
    "success": false,
    "error": "Invalid or expired refresh token"
  }
  ```

---

### Profile Endpoints

#### 5. Get User Profile

Retrieve the authenticated user's profile information.

**Endpoint**: `GET /api/profile`

**Authentication**: Required (Access Token)

**Headers**:

```
Authorization: Bearer <access_token>
```

**Response** (200 OK):

```json
{
  "success": true,
  "profile": {
    "id": "660e8400-e29b-41d4-a716-446655440000",
    "email": "user@example.com",
    "profileImage": "https://example.com/image.jpg",
    "firstName": "John",
    "lastName": "Doe",
    "dob": "1990-01-15",
    "phoneNumber": "+1234567890",
    "gender": "male",
    "createdAt": "2024-01-01T00:00:00.000Z",
    "updatedAt": "2024-01-02T00:00:00.000Z"
  }
}
```

**Error Responses**:

- **401 Unauthorized**: Missing or invalid access token

  ```json
  {
    "success": false,
    "error": "Access token is required"
  }
  ```

  or

  ```json
  {
    "success": false,
    "error": "Invalid or expired access token"
  }
  ```

- **404 Not Found**: Profile not found
  ```json
  {
    "success": false,
    "error": "Profile not found"
  }
  ```

---

#### 6. Update User Profile

Update or create the authenticated user's profile. This endpoint uses upsert behavior - it will create a profile if it doesn't exist, or update it if it does.

**Endpoint**: `PUT /api/profile`

**Authentication**: Required (Access Token)

**Headers**:

```
Authorization: Bearer <access_token>
```

**Request Body** (all fields are optional):

```json
{
  "profileImage": "https://example.com/image.jpg",
  "firstName": "John",
  "lastName": "Doe",
  "dob": "1990-01-15",
  "phoneNumber": "+1234567890",
  "gender": "male"
}
```

**Response** (200 OK):

```json
{
  "success": true,
  "message": "Profile updated successfully",
  "profile": {
    "id": "660e8400-e29b-41d4-a716-446655440000",
    "email": "user@example.com",
    "profileImage": "https://example.com/image.jpg",
    "firstName": "John",
    "lastName": "Doe",
    "dob": "1990-01-15",
    "phoneNumber": "+1234567890",
    "gender": "male",
    "createdAt": "2024-01-01T00:00:00.000Z",
    "updatedAt": "2024-01-02T00:00:00.000Z"
  }
}
```

**Error Responses**:

- **401 Unauthorized**: Missing or invalid access token

  ```json
  {
    "success": false,
    "error": "Access token is required"
  }
  ```

  or

  ```json
  {
    "success": false,
    "error": "Invalid or expired access token"
  }
  ```

- **400 Bad Request**: Invalid date format

  ```json
  {
    "success": false,
    "error": "Invalid date format for dob"
  }
  ```

- **404 Not Found**: User not found
  ```json
  {
    "success": false,
    "error": "User not found"
  }
  ```

**Note**: You can update individual fields by only including the fields you want to change in the request body. Fields not included will remain unchanged (or null if creating a new profile).

---

### Product Endpoints

#### 7. Get Top Selling Items

Retrieve the list of top selling items.

**Endpoint**: `GET /api/topselling`

**Authentication**: Not required

**Response** (200 OK):

```json
{
  "items": [
    {
      "id": 1,
      "name": "Product Name",
      "price": 99.99,
      ...
    }
  ]
}
```

**Error Response** (500 Internal Server Error):

```json
{
  "error": "Failed to fetch top selling items",
  "message": "Error details"
}
```

---

### Utility Endpoints

#### 8. Health Check

Check if the server is running.

**Endpoint**: `GET /health`

**Authentication**: Not required

**Response** (200 OK):

```json
{
  "status": "OK",
  "message": "Server is running"
}
```

---

## Error Handling

All error responses follow a consistent format:

```json
{
  "success": false,
  "error": "Error message description"
}
```

Some errors may also include a `message` field with additional details:

```json
{
  "success": false,
  "error": "Error summary",
  "message": "Detailed error message"
}
```

### Common HTTP Status Codes

- **200 OK**: Request successful
- **201 Created**: Resource created successfully
- **400 Bad Request**: Invalid request data
- **401 Unauthorized**: Authentication required or failed
- **403 Forbidden**: Access denied (e.g., account not verified)
- **404 Not Found**: Resource not found
- **409 Conflict**: Resource already exists
- **500 Internal Server Error**: Server error

---

## Profile Data Fields

### Profile Fields Description

- **profileImage** (String, optional): URL to the user's profile image
- **firstName** (String, optional): User's first name
- **lastName** (String, optional): User's last name
- **dob** (String, optional): Date of birth (recommended format: ISO 8601, e.g., "1990-01-15")
- **phoneNumber** (String, optional): User's phone number
- **gender** (String, optional): User's gender (e.g., "male", "female", "other")

**Note**: The `email` field is automatically retrieved from the User table and cannot be updated through the profile endpoint.

---

## Example Usage

### Complete Authentication Flow

```javascript
// 1. Sign up
const signupResponse = await fetch("http://localhost:3000/api/signup", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({
    email: "user@example.com",
    password: "password123",
  }),
});
const { otp } = await signupResponse.json();

// 2. Verify OTP
await fetch("http://localhost:3000/api/verify-otp", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({
    email: "user@example.com",
    otp: otp,
  }),
});

// 3. Login
const loginResponse = await fetch("http://localhost:3000/api/login", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({
    email: "user@example.com",
    password: "password123",
  }),
});
const { accessToken, refreshToken } = await loginResponse.json();

// 4. Get profile
const profileResponse = await fetch("http://localhost:3000/api/profile", {
  method: "GET",
  headers: {
    Authorization: `Bearer ${accessToken}`,
  },
});
const profile = await profileResponse.json();

// 5. Update profile
await fetch("http://localhost:3000/api/profile", {
  method: "PUT",
  headers: {
    "Content-Type": "application/json",
    Authorization: `Bearer ${accessToken}`,
  },
  body: JSON.stringify({
    firstName: "John",
    lastName: "Doe",
    dob: "1990-01-15",
    phoneNumber: "+1234567890",
    gender: "male",
  }),
});
```

---

## Notes

- All timestamps are returned in ISO 8601 format
- Email addresses are case-insensitive and stored in lowercase
- Access tokens expire after 15 minutes
- Refresh tokens expire after 7 days
- Profile endpoints require a valid access token in the Authorization header
- The profile is automatically linked to the authenticated user based on the access token
