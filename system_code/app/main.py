from fastapi import FastAPI, Request
from pydantic import BaseModel

app = FastAPI()

class Payment(BaseModel):
    amount: float
    to_account: str

@app.post("/payments")
def process_payment(payment: Payment, request: Request):
    # Insecure: no auth, no logging, no signing
    save_to_db(payment.dict())
    return {"status": "ok", "amount": payment.amount}

@app.get("/data")
def get_data():
    # Returns sensitive research data
    with open("data/research.csv") as f:
        return {"data": f.read()}

@app.post("/login")
def login(user: dict):
    # simplistic login endpoint
    token = create_token(user)
    return {"token": token}

# helper functions (placeholders)
def save_to_db(payload):
    # pretend to save
    pass

def create_token(user):
    return "insecure-token"
