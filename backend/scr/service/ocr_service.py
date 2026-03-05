import requests
import json
from config import (
    TYPHOON_API_KEY,
    TYPHOON_OCR_URL
)
def scan_image(
    image_bytes,
    filename,
    content_type
):
    try:
        response = requests.post(
            TYPHOON_OCR_URL,
            headers={
                "Authorization":
                f"Bearer {TYPHOON_API_KEY}"
            },
            files={
                "file": (
                    filename,
                    image_bytes,
                    content_type
                )
            },
            timeout=60,
        )
        response.raise_for_status()
        ocr_result = response.json()
        content = (
            ocr_result["results"][0]
            ["message"]["choices"][0]
            ["message"]["content"]
        )
        print("===== OCR TEXT =====")
        print(content)
        print("====================")

        if isinstance(content, str):
            content = content.strip()
            if content.startswith("{"):
                content = json.loads(content)
        if isinstance(content, dict):
            return content.get(
                "natural_text",
                ""
            )
        return content
    except Exception as e:
        print("OCR SERVICE ERROR:", str(e))
        return ""