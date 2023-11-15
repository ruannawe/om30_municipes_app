class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :citizen, null: false, foreign_key: true
      t.string :zip_code
      t.string :street
      t.string :complement
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :ibge_code

      t.timestamps
    end

    add_index :addresses, :zip_code
    add_index :addresses, :street
    add_index :addresses, :neighborhood
    add_index :addresses, :city
    add_index :addresses, :state
    add_index :addresses, :ibge_code
  end
end
