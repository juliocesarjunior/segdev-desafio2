class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :age
      t.integer :dependents
      t.integer :income
      t.string :marital_status
      t.integer :risk_questions, array: true, default: [0, 0, 0]
      t.json :house
      t.json :vehicle
      t.timestamps
    end
  end
end
