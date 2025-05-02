# Hoppscotch API Tests

This repository contains Hoppscotch API tests for the Chabbi project.

## Test Reports

API test reports are automatically published to GitHub Pages after each workflow run. You can view the latest test reports at:

```
https://YOUR_GITHUB_USERNAME.github.io/YOUR_REPOSITORY_NAME/
```

Replace `YOUR_GITHUB_USERNAME` and `YOUR_REPOSITORY_NAME` with your actual GitHub username and repository name.

## How it Works

The main workflow (`main.yml`) handles both test execution and report publishing:

1. Runs Hoppscotch API tests
2. Generates XML test reports in JUnit format
3. Converts XML reports to HTML format
4. Publishes the HTML reports to GitHub Pages
5. Stores both XML and HTML reports as workflow artifacts

## Setting up GitHub Pages

To enable GitHub Pages for this repository:

1. Go to your repository on GitHub
2. Navigate to Settings > Pages
3. Under "Source", select "GitHub Actions"

After enabling GitHub Pages and pushing to the main branch, the test reports will automatically be available at your GitHub Pages URL.

## Local Development

To run tests locally:

```bash
cd chabbi_project
hopp test auth/auth.json --env temp_env.json
```
