from locust import HttpUser, task, between
import random

class WordPressUser(HttpUser):
    # Define wait time between tasks (e.g., 1 to 3 seconds)
    wait_time = between(1, 3)

    # Common WordPress endpoints to test
    endpoints = [
        "/",  # Home page
        "/wp-json/wp/v2/posts",  # REST API posts
        "/wp-json/wp/v2/pages",  # REST API pages
        "/wp-json/wp/v2/categories",  # REST API categories
        "/feed/",  # RSS feed
        "/wp-content/themes/twentytwenty/style.css",  # Theme stylesheet
        "/wp-content/plugins/akismet/_inc/form.js",  # Plugin JavaScript
        "/wp-content/uploads/sample-image.jpg",  # Uploaded file (replace with an actual path)
    ]

    def on_start(self):
        """Run before the user starts performing tasks."""
        self.log("Starting test for WordPress endpoints")

    def log(self, message):
        print(f"[INFO]: {message}")

    @task
    def test_wordpress_endpoints(self):
        """Randomly select an endpoint to test."""
        endpoint = random.choice(self.endpoints)
        with self.client.get(endpoint, catch_response=True) as response:
            if response.status_code == 200:
                response.success()
                self.log(f"Successfully fetched: {endpoint}")
            else:
                response.failure(f"Failed to fetch {endpoint}. Status: {response.status_code}")

    @task
    def test_specific_post(self):
        """Simulate fetching a specific post."""
        post_id = random.randint(1, 10)  # Replace with actual post IDs or range
        endpoint = f"/wp-json/wp/v2/posts/{post_id}"
        with self.client.get(endpoint, catch_response=True) as response:
            if response.status_code == 200:
                response.success()
                self.log(f"Successfully fetched post ID: {post_id}")
            else:
                response.failure(f"Failed to fetch post ID: {post_id}. Status: {response.status_code}")

if __name__ == "__main__":
    import os
    from locust.main import main

    os.system("locust -f locustfile.py")
