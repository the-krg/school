class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.integer :course_id
      t.text :description
      t.string :name
      t.string :heading
      t.boolean :is_published
      t.string :image_url

      t.timestamps
    end
  end
end
