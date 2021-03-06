class CreateHelpTopics < ActiveRecord::Migration
  def self.up
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
    add_index :help_topics, [:active, :help_category_id, :title], :name => "topics_aht"
  end

  def self.down
    drop_table :help_topics
  end
end
