import base64
import requests

# اطلاعات کاربر
base_url = "https://fms-gateway-staging.apps.public.okd4.teh-1.snappcloud.io"
url = f"{base_url}/api/online/v1/oauth/token"

client_id = "adora-yadak"
client_secret = "t4DjO10vqMdse48L"
username = "adora-yadak-purchase"
password = "TAllrSPuoMu^vc*h"

# ساخت Authorization header از نوع Basic
credentials = f"{client_id}:{client_secret}"
encoded_credentials = base64.b64encode(credentials.encode()).decode()

headers = {
    "Authorization": f"Basic {encoded_credentials}",
    "Content-Type": "application/x-www-form-urlencoded"
}

data = {
    "grant_type": "password",
    "scope": "online-merchant",
    "username": username,
    "password": password
}

print("🔹 Sending request to SnappPay...")
response = requests.post(url, headers=headers, data=data)

print("Status:", response.status_code)
print("Response:")
print(response.text)

