require 'httparty'

class SimilarityService
    include HTTParty
    #vbase_uri 'http://python_api:5000'  # Flask APIのホストとポート
    base_uri ENV.fetch('API_ENDPOINT', 'http://localhost:5000') # デフォルト値としてローカルを指定


    # 2つの単語の類似度を取得するクラスメソッド
    # word1: 類似度を計算する1つ目の単語
    # word2: 類似度を計算する2つ目の単語
    def self.get_similarity(word1, word2)
        # Flask APIにPOSTリクエストを送信
        response = post('/similarity',
            body: { word1: word1, word2: word2 }.to_json,  # リクエストボディに単語をJSON形式で含める
            headers: { 'Content-Type' => 'application/json' }  # リクエストヘッダーにContent-Typeを指定
        )

        # レスポンスが成功した場合
        if response.success?
            # レスポンスから類似度の値を抽出して返す
            response.parsed_response['similarity']
        else
            # レスポンスが失敗した場合、エラーメッセージをログに記録
            Rails.logger.error "Error response from Flask API: #{response.body}"
            nil  # 類似度を取得できなかった場合はnilを返す
        end
    end
end
