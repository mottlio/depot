class CreatePayTypes < ActiveRecord::Migration
  def change
    create_table :pay_types do |t|
      t.string :name
      t.string :string

      t.timestamps
    end
  end
end
