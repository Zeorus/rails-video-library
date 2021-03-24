class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :sinopsis
      t.string :year
      t.string :poster_path

      t.timestamps
    end
  end
end
