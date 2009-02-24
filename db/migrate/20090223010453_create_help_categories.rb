class CreateHelpCategories < ActiveRecord::Migration
  def self.up
    create_table :help_categories do |t|
      t.string    :title, :permalink
      t.boolean   :active, :null => false, :default => true
      t.timestamps
    end
    
    add_index :help_categories, :permalink
    add_index :help_categories, [:active, :permalink]
  end

  def self.down
    drop_table :help_categories
  end
end
