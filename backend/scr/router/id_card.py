from fastapi import APIRouter, Form
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
from service.ocr_service import scan_image
from parsers.id_card import parse_idcard
import base64
router = APIRouter(
    prefix="/idcard",
    tags=["ID Card"]
)
@router.post("/scan")
async def scan_idcard(
    key: str = Form(...),
    iv: str = Form(...),
    data: str = Form(...)
):
    try:
        key_bytes = base64.b64decode(key)
        iv_bytes = base64.b64decode(iv)
        encrypted = base64.b64decode(data)

        cipher = AES.new(
            key_bytes,
            AES.MODE_CBC,
            iv_bytes
        )
        image_bytes = unpad(
            cipher.decrypt(encrypted),
            AES.block_size
        )
        text = scan_image(
            image_bytes,
            "image.jpg",
            "image/jpeg"
        )
        if isinstance(text,list):
            text = " ".join(text)
        result = parse_idcard(text)
        print("PARSED RESULT =====")
        print(result)
        return result
    except Exception as e:
        print("SCAN ERROR:",str(e))
        return {
            "status":"error",
            "message":str(e)
        }