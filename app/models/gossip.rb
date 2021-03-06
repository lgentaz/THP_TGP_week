class Gossip < ApplicationRecord
    belongs_to :user
    has_many :goss_tags, dependent: :destroy
    has_many :tags, through: :goss_tags
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    validates :title, presence: true, length: { in: 3..30 }
    validates :content, presence: true, length: { minimum: 10 }
end
