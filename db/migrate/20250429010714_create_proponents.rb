class CreateProponents < ActiveRecord::Migration[8.0]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :documents
      t.date :birth_date
      t.decimal :salary
      t.decimal :inss_discount

      t.timestamps
    end
  end
end
