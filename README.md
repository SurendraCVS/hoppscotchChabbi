# Hoppscotch API Tests

This repository contains Hoppscotch API tests for the Chaabi application.

## Test Structure

- `chabbi_project/auth/auth.json` - Contains API tests for authentication (login/logout)
- `chabbi_project/env.json` - Environment configuration with base URLs and endpoints

## Running Tests Locally

To run the tests locally, follow these steps:

1. Install the Hoppscotch CLI
   ```
   npm install -g @hoppscotch/cli
   ```

2. Run the authentication tests
   ```
   hopp test ./chabbi_project/auth/auth.json -e ./chabbi_project/env.json
   ```

3. Generate JUnit XML report
   ```
   hopp test ./chabbi_project/auth/auth.json -e ./chabbi_project/env.json --reporter junit
   ```

## CI/CD Pipeline

Tests are automatically run in the CI/CD pipeline via GitHub Actions. The workflow is defined in `.github/workflows/main.yml`.

The pipeline:
1. Runs on push to main/master branch, on pull requests, or can be manually triggered
2. Sets up Node.js environment and installs Hoppscotch CLI
3. Runs the auth.json tests using the credentials already defined in the test file
4. Generates JUnit test reports
5. Uploads and publishes test results as artifacts in GitHub

## Adding New Tests

To add new tests:
1. Create a new JSON file in the appropriate directory following the Hoppscotch format
2. Add your API requests with test scripts
3. Update the CI/CD pipeline in main.yml if needed to include the new test file
