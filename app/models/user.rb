class User < ApplicationRecord
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :dependents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :income, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :marital_status, presence: true, inclusion: { in: ['single', 'married'] }
  validates :risk_questions, presence: true, length: { is: 3 }
  validate :validate_house_presence
  validate :validate_vehicle_presence

  private

 def validate_house_presence
    if house.present? && !['owned', 'rented'].include?(house['ownership_status'])
      errors.add(:house, 'status de propriedade deve ser "owned" ou "rented"')
    end
  end

  def validate_vehicle_presence
    if vehicle.present? && vehicle['year'].blank?
      errors.add(:vehicle, 'ano não pode estar em branco')
    end
  end
end
