import requests
import json

# GitHub API URL for search
url = "https://api.github.com/search/repositories?q=SELECT+JOIN+language:SQL&per_page=100&page=1"

# Send GET request to GitHub API
response = requests.get(url)

# Check if the request was successful
if response.status_code == 200:
    data = response.json()
    ssh_urls = []

    # Extract ssh_url from each item in the response
    for item in data['items']:
        repo_url = item['ssh_url']
        ssh_urls.append(repo_url)

    # Write the ssh_urls to a file
    with open('ssh_urls.txt', 'w') as file:
        for url in ssh_urls:
            file.write(url + '\n')

    print("SSH URLs have been written to ssh_urls.txt")
else:
    print(f"Failed to fetch data from GitHub API. Status code: {response.status_code}")
