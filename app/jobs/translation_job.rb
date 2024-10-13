class TranslationJob < ApplicationJob
    queue_as :default

    def perform(tag_id)
        tag = Tag.find(tag_id)
        return unless tag # タグが存在しない場合はジョブを終了

        translated_name = translate(tag.name)
        tag.update(name_en: translated_name)
    end

    private

    def translate(text)
        translator = Google::Cloud::Translate.translation_v2_service
        translation = translator.translate(text, to: "en")
        translation.text
        rescue => e
        Rails.logger.error "Translation error for tag '#{text}': #{e.message}"
        text # エラーの場合は元のテキストを返す
    end
end
