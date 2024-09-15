
## Production Grade Laravel Docker Setup

A robust, scalable, and production-ready Docker setup for Laravel applications, designed to simplify deployment, enhance performance, and ensure security.

### Introduction

This project provides a comprehensive Docker setup tailored for Laravel applications, enabling developers to easily deploy their applications in a production environment. It leverages best practices for containerization and scalability to ensure your Laravel applications run smoothly in any production setting.

### Features

- **Base Image**: Extends from `chialab/php:8.3-apache`, which includes all essential PHP extensions for Laravel,composer installed, ensuring compatibility and optimal performance.
- **Apache with PHP-FPM**: Integrated web server and PHP-FPM configuration for better performance.
- **Automated Data Seeding and Migrations**: Configured to run database migrations and seed data automatically when the container starts, eliminating the need to manually exec into the running container. This feature is designed to support deployment on platforms like AWS ECS and other container orchestration services.

### Installation

1. **Download the Repository an**
    Download the repo and copy over the files and folder to your project root


2. **Build the Docker Image**

   Run the following command to build the Docker image:

   ```bash
   docker build -t laravel-app .
   ```

3. **Run the Docker Container**

   Start the container with the following command:

   ```bash
   docker run --env-file .env -p 8080:80 --name laravel-app -d laravel-app
   ```

4. **Automated Migrations and Seeding**
    By default migrations are made, to remove this behaviour, add the environmental variable `MAKE_MIGRATIONS=false` to your `.env` file.
    To seed your data when the container starts, add the environmental variable `SEED_DATA=true` to your `.env` file. 