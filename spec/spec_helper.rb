ENV["RAILS_ENV"] = "test"
 
require "config/environment"
require "spec"
require "spec/rails"
require "ruby-debug"
require "test_notifier/rspec"
require "hpricot"
 
ActiveRecord::Base.configurations = {"test" => {:adapter => "sqlite3", :database => ":memory:"}}
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations["test"])
ActiveRecord::Base.logger = Logger.new("log/plugin.log")
 
load(File.dirname(__FILE__) + "/schema.rb")
 
Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = File.dirname(__FILE__) + "/fixtures/"
end

silence_warnings do
  HelpTopic::HELP_DIR = File.dirname(__FILE__) + "/fixtures"
  HelpTopic::CONFIG = File.dirname(__FILE__) + "/fixtures/help.yml"
end
 
class Object
  def self.unset_class(*args)
    class_eval do 
      args.each do |klass|
        eval(klass) rescue nil
        remove_const(klass) if const_defined?(klass)
      end
    end
  end
end
 
alias :doing :lambda