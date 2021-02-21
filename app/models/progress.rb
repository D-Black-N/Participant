class Progress < ApplicationRecord
  validates  :name, :surname, :activity, :result, presence: true, length: { minimum: 2, maximum: 30 }
  validates :classroom, presence: true
  
end
