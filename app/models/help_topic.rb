class HelpTopic < ActiveRecord::Base
  # constants
  HELP_DIR = "#{RAILS_ROOT}/config/help"
  CONFIG  = "#{HELP_DIR}/help.yml"
  
  # associations
  belongs_to :category, :class_name => "HelpCategory", :foreign_key => "help_category_id"
  
  # plugins
  has_permalink :title
  has_markup    :content,
    :format   => :textile,
    :sanitize => false
  
  # scopes
  named_scope :active, :conditions => {:active => true}, :order => "title asc"
  named_scope :inactive, :conditions => {:active => false}, :order => "title asc"
  named_scope :summary, :conditions => {:active => true}, :limit => 5, :order => "title asc"
  
  def to_param
    permalink
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
    @_help_config ||= YAML.load_file(CONFIG)
  end
end