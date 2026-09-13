from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
import numpy as np
import joblib
import os


app = FastAPI()



BASE_DIR = os.path.dirname(
    os.path.dirname(
        os.path.abspath(__file__)
    )
)

MODEL_FILE = os.path.join(
    BASE_DIR,
    "models",
    "elastic_net_model4.pkl"
)

model = joblib.load(MODEL_FILE)


class MovieInput(BaseModel):
    title: str
    budget: float
    runtime: float
    release_year: int
    release_month: int
    original_language: str
    main_country: str
    genres: list[str]


@app.get("/")
def home():
    return {
        "message": "Box Office Prediction API is running"
    }


@app.post("/predict")
def predict(movie: MovieInput):

    data = {
        "budget": movie.budget,
        "log_budget": np.log1p(movie.budget),
        "runtime": movie.runtime,
        "release_year": movie.release_year,
        "release_month": movie.release_month,
        "original_language": movie.original_language,
        "main_country": movie.main_country
    }

    genres = [
        "action",
        "adventure",
        "animation",
        "comedy",
        "crime",
        "documentary",
        "drama",
        "family",
        "fantasy",
        "history",
        "horror",
        "music",
        "mystery",
        "romance",
        "science_fiction",
        "thriller",
        "war",
        "western"
    ]

    for genre in genres:
        genre_name = genre.replace("_", " ").title()

        data["genre_" + genre] = (
            1 if genre_name in movie.genres else 0
        )

    movie_data = pd.DataFrame([data])

    predicted_log_revenue = model.predict(movie_data)[0]

    predicted_revenue = np.expm1(
        predicted_log_revenue
    )

    return {
        "title": movie.title,
        "predicted_revenue": round(
            float(predicted_revenue),
            2
        ),
        "predicted_revenue_millions": round(
            float(predicted_revenue / 1_000_000),
            2
        )
    }