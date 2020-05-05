class Tag < ApplicationRecord
    has_many :goss_tags, dependent: :destroy
    has_many :gossips, through: :goss_tags
    validates :title, presence: true    
end
