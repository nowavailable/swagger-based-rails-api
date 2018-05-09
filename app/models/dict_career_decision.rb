class DictCareerDecision < ApplicationRecord
  validates :label, presence: true
  validates :key, presence: true

  SEED = {
    "1" => "理系選択済み",
    "2" => "理系選択志望",
    "3" => "どちらとも言えない",
    "4" => "文系選択志望",
    "5" => "文系選択済み",
  }
end
