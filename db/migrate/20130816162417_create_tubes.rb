class CreateTubes < ActiveRecord::Migration
  def change
    create_table :tubes, :force => true do |t|
      t.string :title
      t.string :link
      t.integer :rank

      t.timestamps
    end
  end
end
