class HelpTopic < ActiveRecord::Base
  # constants
  HELP_DIR = "#{RAILS_ROOT}/config/help"
  CONFIG  = "#{HELP_DIR}/help.yml"
  
  # associations
  belongs_to :category, :class_name => "HelpCategory", :foreign_key => "help_category_id"
  
  # plugins
  has_permalink :title
  has_markup    :content, :format => :textile
  
  # scopes
  named_scope :active, :conditions => {:active => true}
  named_scope :inactive, :conditions => {:active => false}
  
  def to_param
    permalink
  end
  
  def page_view!
    update_attribute :views, views + 1
  end
  
  def self.import!
    config.each do |category_name, questions|
      category = HelpCategory.find_or_create_by_title(category_name)
      category.update_attribute :title, category_name

      questions.each do |title, file|
        question = HelpTopic.find_or_create_by_title(title)

        question.update_attributes({
          :title      => title,
          :content    => File.read("#{HELP_DIR}/#{file}"),
          :category   => category
        })
      end
    end
  end
  
  def self.config
    @config ||= YAML.load_file(CONFIG)
  end
end