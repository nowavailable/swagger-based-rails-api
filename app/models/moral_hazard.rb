class MoralHazard < ApplicationRecord
  belongs_to :user
  belongs_to :entry, polymorphic: true
end
