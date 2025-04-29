# Hoppscotch API Test Project

This project contains API tests for the Chaabi Dev API using Hoppscotch CLI.

## Project Structure

- `chabbi_project/` - Main project directory
  - `auth/` - Authentication API tests
    - `auth.json` - Hoppscotch collection file with login/logout tests
    - `test-results.xml` - JUnit test results
  - `env.json` - Environment variables for API endpoints

## GitHub Actions Workflow

This project includes a GitHub Actions workflow that:
1. Runs Hoppscotch API tests against the Chaabi Dev API
2. Generates JUnit test reports
3. Uploads test results as artifacts

The workflow uses a custom polyfill implementation for the `File` and `Blob` objects that are required by Hoppscotch CLI but are not available in the Node.js environment.

## Running Tests Locally

To run the tests locally, follow these steps:

1. Install Hoppscotch CLI:
   ```
   npm install -g @hoppscotch/cli
   ```

2. Navigate to the project directory:
   ```
   cd chabbi_project
   ```

3. Run the tests using our custom runner script:
   ```
   node run-tests.js
   ```

4. Generate JUnit test report:
   ```
   node run-tests.js --junit
   ```

This script automatically handles:
- Adding the required File and Blob polyfills for Node.js
- Converting the environment file to the correct format
- Running the tests and generating reports

## Implementation Details

The `run-tests.js` script:
1. Provides polyfills for `File` and `Blob` objects
2. Converts the environment format if needed
3. Creates a temporary environment file in the format expected by Hoppscotch CLI
4. Runs the tests using the Hoppscotch CLI
5. Cleans up temporary files

## Troubleshooting

If you encounter issues running the tests:

1. Make sure Hoppscotch CLI is installed: `npm install -g @hoppscotch/cli`
2. Check that your collection and environment files match the formats shown below
3. Try running with verbose logging: `DEBUG=* node run-tests.js`

## Hoppscotch File Formats

The project uses the following formats:

### Collection Format (auth.json)
```json
{
  "v": 2,
  "name": "collection-name",
  "folders": [],
  "requests": [
    {
      "v": 2,
      "endpoint": "<<apiBaseURL>><<endpoint>>",
      "name": "request-name",
      "method": "GET",
      // ... other properties
    }
  ]
}
```

### Environment Format (env.json)
```json
{
  "name": "environment-name",
  "variables": {
    "key1": "value1",
    "key2": "value2"
  }
}
```

Make sure your files match these formats exactly as Hoppscotch CLI is quite strict about the format. 