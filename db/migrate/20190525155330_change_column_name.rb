class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :when, :timing
  end
end
