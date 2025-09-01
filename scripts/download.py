import requests
import sys

file_path = "vndb-db-latest.tar.zst"

link = f"https://dl.vndb.org/dump/{file_path}"


try:
    response = requests.get(link, timeout=30)
    response.raise_for_status() 
    
    
    with open(file_path, 'wb') as file:
        file.write(response.content)
    print('File downloaded successfully')
    
except requests.exceptions.RequestException as e:
    print(f'Download failed: {e}')
    sys.exit(1)
except IOError as e:
    print(f'File write failed: {e}')
    sys.exit(1)