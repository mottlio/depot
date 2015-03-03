class AddPayTypeIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :pay_type_id, :string
    add_column :orders, :integer, :string
  end
end
