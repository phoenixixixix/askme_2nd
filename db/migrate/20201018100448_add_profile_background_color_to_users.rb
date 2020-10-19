class AddProfileBackgroundColorToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :prof_bg_color, :string
  end
end
