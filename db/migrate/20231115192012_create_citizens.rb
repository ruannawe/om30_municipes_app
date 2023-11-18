class CreateCitizens < ActiveRecord::Migration[7.1]
  def change
    create_table :citizens do |t|
      t.string :full_name, null: false
      t.string :tax_id, null: false
      t.string :national_health_card, null: false
      t.string :email, null: false
      t.date :birthdate, null: false
      t.string :phone, null: false
      t.string :photo
      t.boolean :status, default: false

      t.timestamps
    end

    add_index :citizens, :tax_id, unique: true
    add_index :citizens, :full_name
    add_index :citizens, :national_health_card
    add_index :citizens, :email, unique: true
    add_index :citizens, :birthdate
    add_index :citizens, :phone
  end
end
