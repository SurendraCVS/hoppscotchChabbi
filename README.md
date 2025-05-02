# Hoppscotch API Testing Suite for Chaabi

This repository contains a comprehensive suite of Hoppscotch API tests for the Chaabi application, designed to ensure reliable API functionality and performance.

## About Hoppscotch

[Hoppscotch](https://hoppscotch.io/) is an open-source API development ecosystem that helps you create, test, and document APIs with ease. It offers a lightweight, web-based alternative to Postman with support for REST, GraphQL, WebSockets, and more.

## Repository Overview

This test suite validates critical API endpoints including:
- Authentication flows (login/logout)
- Data validation and error handling
- Performance benchmarking

## Test Structure

- `chabbi_project/auth/auth.json` - Contains API tests for authentication (login/logout)
- `chabbi_project/env.json` - Environment configuration with base URLs and endpoints

## Running Tests Locally

To run the tests locally, follow these steps:

1. Install the Hoppscotch CLI
   ```bash
   npm install -g @hoppscotch/cli
   ```

2. Run the authentication tests
   ```bash
   hopp test ./chabbi_project/auth/auth.json -e ./chabbi_project/env.json
   ```

3. Generate JUnit XML report
   ```bash
   hopp test ./chabbi_project/auth/auth.json -e ./chabbi_project/env.json --reporter junit
   ```

## Benefits of API Testing

- **Early Detection**: Find issues in the API before they reach production
- **Reliability**: Ensure consistent behavior across environments
- **Integration Validation**: Verify your API works correctly with other systems
- **Documentation**: Tests serve as living documentation of expected API behavior

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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).
