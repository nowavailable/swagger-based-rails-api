class DictDirectMailOptIn < ApplicationRecord
  validates :label, presence: true
  validates :key, presence: true

  SEED = {
    "1" => "Rikejo Life メールマガジン",
    "2" => "講談社からのお知らせ",
  }
end
