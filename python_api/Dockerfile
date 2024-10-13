FROM python:3.9
WORKDIR /app

# システムの依存関係をインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev

# pipをアップグレード
RUN pip install --no-cache-dir --upgrade pip

# 必要なPythonパッケージをインストール
RUN pip install Flask spacy
RUN python -m spacy download en_core_web_md


COPY . .
CMD ["python", "app.py"]
