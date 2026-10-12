FROM tensorflow/tensorflow:2.17.0

WORKDIR /app

COPY backend/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --ignore-installed -r /tmp/requirements.txt \
    && python -m nltk.downloader -d /usr/local/nltk_data punkt punkt_tab wordnet omw-1.4

COPY backend/artifacts /model
COPY backend/data/workouts_db.sql /seed/workouts_db.sql
COPY backend /app

ENV NLTK_DATA=/usr/local/nltk_data
EXPOSE 5000
CMD ["python", "app.py"]
