class CreateOpenListsDomains < ActiveRecord::Migration
  def change
    create_table :open_lists_domains do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
