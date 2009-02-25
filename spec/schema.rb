ActiveRecord::Schema.define(:version => 0) do
  create_table :help_categories do |t|
    t.string    :title, :permalink
    t.boolean   :active, :null => false, :default => true
    t.timestamps
  end
  
  add_index :help_categories, :permalink
  add_index :help_categories, [:active, :permalink]
  
  create_table :help_topics do |t|
    t.references  :help_category
    t.string      :title, :permalink
    t.text        :content, :formatted_content
    t.boolean     :active, :null => false, :default => true
    t.timestamps
  end
  
  add_index :help_topics, :permalink
  add_index :help_topics, [:active, :permalink]
  add_index :help_topics, [:help_category_id, :active]
end