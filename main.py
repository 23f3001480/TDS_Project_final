from fastapi import FastAPI, File, UploadFile, Form, HTTPException
from fastapi.responses import JSONResponse

app = FastAPI()

@app.post("/submit/")
async def submit_question(
    question: str = Form(...), 
    file: UploadFile = File(None)  # File is optional
):
    if not question.strip():
        raise HTTPException(status_code=400, detail="Question is required.")

    response_data = {"question": question}

    # Accessing 'UploadFile' attributes to avoid warning
    if file:
        content = await file.read()  # Reading the file data
        response_data["file_info"] = {
            "filename": file.filename,
            "content_type": file.content_type,
            "size": len(content)
        }

    return JSONResponse(content=response_data)
