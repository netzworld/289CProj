import requests
import os
import subprocess
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()
ACCESS_TOKEN = os.getenv("ACCESS_TOKEN")

if not ACCESS_TOKEN:
    raise ValueError("GitHub ACCESS_TOKEN is missing. Ensure it's set in your .env file.")

# GitHub API request headers
headers = {
    "Authorization": f"Bearer {ACCESS_TOKEN}",
    "Accept": "application/vnd.github.v3+json",
    "X-GitHub-Api-Version": "2022-11-28"
}

# API URL to search for repositories containing SQL queries
url = "https://api.github.com/search/repositories?q=SELECT+language:SQL&per_page=10&page=1"

# Make the request
response = requests.get(url, headers=headers)

if response.status_code == 200:
    data = response.json()
    ssh_urls = [item["clone_url"] for item in data.get("items", [])]

    # Create directories for cloning and storing SQL files
    os.makedirs("cloned_repos", exist_ok=True)
    os.makedirs("sql_files", exist_ok=True)

    for repo_url in ssh_urls:
        repo_name = repo_url.split("/")[-1].replace(".git", "")
        repo_path = os.path.join("cloned_repos", repo_name)

        # Clone the repository if not already cloned
        if not os.path.exists(repo_path):
            print(f"Cloning {repo_url}...")
            subprocess.run(["git", "clone", "--depth", "1", repo_url, repo_path], check=True)

        # Find and copy all .sql files
        for root, _, files in os.walk(repo_path):
            for file in files:
                if file.endswith(".sql"):
                    src_path = os.path.join(root, file)
                    dest_path = os.path.join("sql_files", f"{repo_name}__{file}")

                    # Copy the .sql file to the sql_files folder
                    with open(src_path, "r", encoding="utf-8", errors="ignore") as src_file:
                        with open(dest_path, "w", encoding="utf-8") as dest_file:
                            dest_file.write(src_file.read())

                    print(f"Saved: {dest_path}")

    print("SQL files have been stored in the 'sql_files/' folder.")
else:
    print(f"Failed to fetch data from GitHub API. Status code: {response.status_code}")
    print("Response:", response.json())
