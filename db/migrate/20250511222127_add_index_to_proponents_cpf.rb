class AddIndexToProponentsCpf < ActiveRecord::Migration[8.0]
  def change
    add_index :proponents, :cpf, unique: true
  end
end
