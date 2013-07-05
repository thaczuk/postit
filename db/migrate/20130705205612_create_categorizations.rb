class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.belongs_to :post
      t.belongs_to :category

      t.timestamps
    end
  end
end
