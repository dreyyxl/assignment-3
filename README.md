# Assignment 3 — DevOps CLI with Docker and CI/CD

## Project Overview

This project is a Bash-based command-line application that provides system information, hostname resolution, and TCP connectivity checks.

The project demonstrates Bash scripting, automated testing, Docker containerization, Docker Compose, and GitHub Actions CI.

## Project Structure

```text
assignment-3/
├── app/
│   └── app.sh
├── scripts/
│   ├── lint.sh
│   └── build.sh
├── tests/
│   └── test.sh
├── .github/
│   └── workflows/
│       └── ci.yml
├── Dockerfile
├── compose.yaml
├── .dockerignore
├── README.md
└── grade.sh
```

## Application Commands

Display help:

```bash
./app/app.sh help
```

Display system information:

```bash
./app/app.sh system-info
```

Resolve a hostname:

```bash
./app/app.sh check-host google.com
```

Check TCP connectivity:

```bash
./app/app.sh check-port google.com 443
```

## Exit Codes

- `0`: Successful execution
- `1`: Operation failed
- `2`: Invalid command or arguments

## Linting and Testing

Run lint checks:

```bash
./scripts/lint.sh
```

Run eight automated tests:

```bash
./tests/test.sh
```

## Docker

Build the image:

```bash
docker build -t devops-tool .
```

Run the application:

```bash
docker run --rm devops-tool help
```

Run automated Docker build and smoke tests:

```bash
./scripts/build.sh
```

## Docker Compose

Validate the configuration:

```bash
docker compose config
```

Run the application:

```bash
docker compose run --rm devops-tool system-info
```

## CI/CD Pipeline

GitHub Actions automatically runs on pushes and pull requests.

The pipeline contains three dependent jobs:

1. **Validate:** Check required files and Bash syntax.
2. **Test:** Execute eight automated Bash tests.
3. **Docker:** Build the Docker image and run smoke tests.

Job execution order:

Validate → Test → Docker

The pipeline stops progressing if a required job fails.

## Technologies

- Bash
- Linux
- Git and GitHub
- Docker
- Docker Compose
- GitHub Actions

## CI Failure and Recovery Demonstration

A controlled CI failure was performed on the `feature/ci-failure-demo` branch to verify that GitHub Actions detects invalid code.

### Failure Demonstration

1. Created the `feature/ci-failure-demo` branch.
2. Introduced an invalid Bash statement (`if then`) in `app/app.sh`.
3. Committed and pushed the change to GitHub.
4. GitHub Actions detected the syntax error during the validation job.
5. The automated tests and Docker build jobs were skipped because they depended on successful validation.

**Failed CI run:** [View failed workflow](https://github.com/dreyyxl/assignment-3/actions/runs/39811919381)

### Recovery Demonstration

1. Removed the invalid Bash statement.
2. Executed `bash scripts/lint.sh` successfully.
3. Executed `bash tests/test.sh`, obtaining 8 passed and 0 failed.
4. Committed and pushed the correction.
5. GitHub Actions successfully completed all three jobs.

**Successful recovery run:** [View successful workflow](https://github.com/dreyyxl/assignment-3/actions/runs/39812842528)

### Pull Request

The corrected feature branch was merged into `main` through [Pull Request #1](https://github.com/dreyyxl/assignment-3/pull/1).

This demonstration confirms that the CI pipeline can detect invalid Bash code, prevent dependent jobs from executing, and validate corrections before integration.