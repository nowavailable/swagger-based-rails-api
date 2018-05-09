class DictNotificationOptIn < ApplicationRecord
  validates :label, presence: true
  validates :key, presence: true

  SEED = {
    "00" => "システムからのお知らせ",
    "10" => "すべての新着質問を通知",
    "20" => "選択した分野の新着質問を通知",
    "30" => "回答した質問に対する他の回答を通知",
    "40" => "すべての新着記事を通知",
    "50" => "選択した分野の新着記事を通知",
  }
end
