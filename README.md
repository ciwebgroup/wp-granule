# WP-Granule

WP-Granule is a comprehensive tool designed to streamline the debugging and profiling process for WordPress developers. It offers features such as database migration management, profiling with Xdebug, and OpenTelemetry integration to help you identify and resolve issues efficiently.

## Features

- **Database Migration Management**: Easily manage and migrate your WordPress database.
- **Profiling with Xdebug**: Gain insights into your code execution and performance.
- **OpenTelemetry Integration**: Collect and analyze telemetry data for better observability.

## Software Requirements

- Node.js 14 or higher
- Docker / Docker Compose

## Installation

Follow these steps to set up WP-Granule:

1. **Clone the repository**:
  ```sh
  git clone https://github.com/yourusername/wp-granule.git
  cd wp-granule
  ```

2. **Install PHP dependencies**:
  ```sh
  composer install
  ```

3. **Install Node.js dependencies**:
  ```sh
  npm install
  ```

4. **Optionally migrate your site**:
  ```sh
  php artisan migrate
  ```

5. **Bring up the solution**:
  ```sh
  npm run start
  ```

## NPM Scripts

- **`npm run start`**: Starts the development server.
- **`npm run build`**: Builds the project for production.
- **`npm run test`**: Runs the test suite.
- **`npm run lint`**: Lints the codebase for style and syntax issues.

## Usage

### Database Migration Management

Use this feature when you need to update your database schema or migrate data. It helps ensure your database is always in sync with your codebase.

### Profiling with Xdebug

Run Xdebug profiling when you experience performance issues or need to understand the execution flow of your code. It helps identify bottlenecks and optimize performance.

### OpenTelemetry Integration

Use OpenTelemetry to collect and analyze telemetry data. This is useful for monitoring the health and performance of your application in real-time.

## When to Use Each Tool

- **Database Migration Management**: Use when deploying new features that require database changes.
- **Profiling with Xdebug**: Use when you notice slow performance or need detailed execution insights.
- **OpenTelemetry Integration**: Use for continuous monitoring and observability to catch issues early.

By following these guidelines, you can effectively utilize WP-Granule to maintain and optimize your WordPress projects.
