# Chabbi Project API Tests

This project contains automated API tests using Hoppscotch CLI that are run through GitHub Actions.

## Project Structure

```
chabbi_project/
├── .github/
│   └── workflows/
│       └── hoppscotch-tests.yml  # GitHub Actions workflow
├── auth/
│   └── auth.json                 # Hoppscotch collection with login API test
├── env.json                      # Global environment file with base URLs and endpoints
└── README.md                     # This file
```

## Environment Configuration

The global environment file (`env.json`) contains:

- Base URLs for the API endpoints
- Endpoint paths for login and logout

The structure of the environment file is:

```json
{
  "baseURL": "https://chaabi-dev.ipxp.in",
  "apiBaseURL": "https://chaabi-dev.ipxp.in/api",
  "loginEndpoint": "/login/",
  "logoutEndpoint": "/logout/"
}
```

## Test Assertions

The tests include strict assertions that enforce successful responses:

1. **Login Assertion**: Requires HTTP status code 200 to pass
   ```javascript
   pw.test("Login status code is 200", () => {
     pw.expect(pw.response.status).toBe(200);
   });
   ```

2. **Logout Assertion**: Requires HTTP status code 200 to pass
   ```javascript
   pw.test("Logout status code is 200", () => {
     pw.expect(pw.response.status).toBe(200);
   });
   ```

These strict assertions ensure that the API endpoints are functioning correctly. Tests will fail if any non-200 status code is returned.

## Direct CSRF Token Handling

The system extracts and uses CSRF tokens directly from the login response:

1. **Login Request**: Sends a POST request to the login endpoint without a CSRF token
2. **Token Extraction**: Login test script extracts the new token from:
   - Set-Cookie header
   - X-CSRFToken header
   - Response body (looking for a csrf_token field)
3. **In-Memory Storage**: The extracted token is temporarily stored in the session-only environment variable:
   - `csrfToken`: Used in the subsequent logout request
4. **Logout Request**: Uses the extracted token directly via the `<<csrfToken>>` placeholder
5. **No Persistence**: The token is not stored in the env.json file between test runs

This approach ensures:
- CSRF tokens are only used within their valid session
- No sensitive tokens are stored in version control
- Each test run naturally uses fresh tokens
- Tests are self-contained and don't depend on previous runs

## CI/CD Pipeline

The CI/CD pipeline is implemented using GitHub Actions and performs the following steps:

1. Checks out the repository code
2. Sets up Node.js environment
3. Installs Hoppscotch to run in the cicd pipeline
4. Runs the Hoppscotch tests using the global environment file
5. Generates a JUnit test report
6. Uploads test results as artifacts

## Running Tests Locally

To run the tests locally:

```bash
# Navigate to the auth directory
cd chabbi_project/auth

# Run the tests with the global environment file
hopp test auth.json -e ../env.json

# Generate a JUnit report (optional)
hopp test auth.json -e ../env.json --reporter-junit test-results.xml
```

## GitHub Actions Workflow

The workflow is triggered on:
- Push to main/master branch
- Pull requests to main/master branch
- Manual trigger (workflow_dispatch)

## Test Results

Test results are available as artifacts in the GitHub Actions workflow run. They can be downloaded after the workflow completes. 



