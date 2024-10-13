from flask import Flask, request, jsonify
import spacy
import logging

# ロギングの設定
logging.basicConfig(level=logging.INFO)

# Flaskアプリケーションを初期化
app = Flask(__name__)

# spaCyのモデルをロード
try:
    nlp = spacy.load("en_core_web_md")
    app.logger.info("Successfully loaded spaCy model")
except Exception as e:
    app.logger.error(f"Failed to load spaCy model: {e}")
    nlp = None

# ルートエンドポイント
@app.route('/')
def home():
    return jsonify({"message": "Welcome to the Similarity API"}), 200

# ヘルスチェックエンドポイント
@app.route('/health')
def health():
    if nlp is None:
        return jsonify({"status": "unhealthy", "message": "spaCy model not loaded"}), 500
    return jsonify({"status": "healthy"}), 200

# /similarity エンドポイントに対する POST リクエストの処理
@app.route('/similarity', methods=['POST'])
def get_similarity():
    if nlp is None:
        return jsonify({"error": "Service unavailable - model not loaded"}), 503

    try:
        data = request.json
        if not data:
            return jsonify({"error": "No JSON data provided"}), 400

        word1 = data.get('word1')
        word2 = data.get('word2')

        if not word1 or not word2:
            return jsonify({"error": "Both word1 and word2 are required"}), 400

        similarity_score = calculate_word_similarity(word1, word2)
        return jsonify({"similarity": similarity_score})

    except Exception as e:
        app.logger.error(f"Error processing similarity request: {e}")
        return jsonify({"error": "Internal server error"}), 500

def calculate_word_similarity(word1, word2):
    token1 = nlp(word1)
    token2 = nlp(word2)
    return token1.similarity(token2)

if __name__ == '__main__':
    app.logger.info("Starting Flask application on port 5000")
    app.run(host='0.0.0.0', port=5000)
