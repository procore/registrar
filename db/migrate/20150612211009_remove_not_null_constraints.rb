class RemoveNotNullConstraints < ActiveRecord::Migration
  def change
    change_column_null :registrar_procore_users, :first_name, true
    change_column_null :registrar_procore_users, :last_name, true
  end
end
