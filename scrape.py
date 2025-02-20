import requests
import json
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Read the access token
ACCESS_TOKEN = os.getenv("ACCESS_TOKEN")

if not ACCESS_TOKEN:
    raise ValueError("GitHub ACCESS_TOKEN is missing. Ensure it's set in your .env file.")

# Set up the headers for authentication
headers = {
    "Authorization": f"Bearer {ACCESS_TOKEN}",
    "Accept": "application/vnd.github.v3+json",
    "X-GitHub-Api-Version": "2022-11-28"
}

# GitHub API URL to search for repositories containing SQL queries
url = "https://api.github.com/search/repositories?q=SELECT+language:SQL&per_page=100&page=1"

# Make the request
response = requests.get(url, headers=headers)

if response.status_code == 200:
    data = response.json()
    ssh_urls = [item['ssh_url'] for item in data.get('items', [])]

    # Write SSH URLs to a file
    with open("ssh_urls.txt", "w") as file:
        file.writelines(f"{url}\n" for url in ssh_urls)

    print(f"SSH URLs saved to ssh_urls.txt ({len(ssh_urls)} repositories found).")
else:
    print(f"Failed to fetch data from GitHub API. Status code: {response.status_code}")
    print("Response:", response.json())
