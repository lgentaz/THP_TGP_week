class City < ApplicationRecord
    has_many :users
    validates :name, presence: true
    validates :zip_code,
    format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, message: "Veuillez entrer un code postal français" }
end
