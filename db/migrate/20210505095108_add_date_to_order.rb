class AddDateToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :date, :date
  end
end
