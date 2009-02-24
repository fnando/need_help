class HelpCategory < ActiveRecord::Base
  # associations
  has_many :topics, :class_name => "HelpTopic", :foreign_key => "help_category_id"
  
  # plugins
  has_permalink :title
  
  # scopes
  named_scope :active, :conditions => {:active => true}
  named_scope :inactive, :conditions => {:active => false}
  
  def to_param
    permalink
  end
end