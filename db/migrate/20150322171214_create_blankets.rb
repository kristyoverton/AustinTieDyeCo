class CreateBlankets < ActiveRecord::Migration
  def change
    create_table :blankets do |t|
      t.text :desc
      t.string :creators
      t.text :story
      t.float :price
      t.references :user, index: true
      t.string :image
      t.string :name

      t.timestamps
    end
  end
end
