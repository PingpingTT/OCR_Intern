from fastapi import FastAPI
from router.id_card import router as idcard_router

app = FastAPI(
    title="OCR Backend"
)
app.include_router(idcard_router)