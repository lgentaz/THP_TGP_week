class PrivateMessage < ApplicationRecord
    belongs_to :sender, class_name: "User"
    belongs_to :recipient, class_name: "User"
    validates :content, presence: true, length: { minimum: 10 }
    validates :sender, presence: true
    validates :recipient, presence: true
    
end
