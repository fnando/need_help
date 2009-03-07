require File.dirname(__FILE__) + "/spec_helper"

describe "need help plugin" do
  before(:each) do
    HelpTopic.import!
    
    @general = HelpCategory.find_by_permalink("general")
    @feedback = HelpCategory.find_by_permalink("feedback")
  end
  
  it "should override constants" do
    HelpTopic::CONFIG.should == File.expand_path(File.dirname(__FILE__) + "/fixtures/help.yml")
    HelpTopic::HELP_DIR.should == File.expand_path(File.dirname(__FILE__) + "/fixtures")
  end
  
  describe HelpCategory do
    it "should return active topics" do
      HelpCategory.first.update_attribute(:active, false)
      HelpCategory.active.count.should == 1
    end
    
    it "should be sorted by title" do
      HelpCategory.active.proxy_options[:order].should == "title asc"
      HelpCategory.inactive.proxy_options[:order].should == "title asc"
    end
    
    it "should return inactive topics" do
      HelpCategory.first.update_attribute(:active, false)
      HelpCategory.inactive.count.should == 1
    end
    
    it "should override to_param" do
      @general.to_param.should == "general"
    end
    
    it "should set attributes" do
      @general.title.should == "General"
      @general.should be_active
    end
  end
  
  describe HelpTopic do
    it "should import all data" do
      HelpTopic.count.should == 9
      HelpCategory.count.should == 2
    end
    
    it "should associate categories and topics" do
      @general.topics.count.should == 6
      @feedback.topics.count.should == 3
    end
    
    it "should return active topics" do
      HelpTopic.first.update_attribute(:active, false)
      HelpTopic.active.count.should == 8
    end
    
    it "should be sorted by title" do
      HelpTopic.active.proxy_options[:order].should == "title asc"
      HelpTopic.inactive.proxy_options[:order].should == "title asc"
    end
    
    it "should return inactive topics" do
      HelpTopic.first.update_attribute(:active, false)
      HelpTopic.inactive.count.should == 1
    end
    
    it "should override to_param" do
      @topic = HelpTopic.find_by_permalink!("how-does-your-refund-policy-work")
      @topic.to_param.should == "how-does-your-refund-policy-work"
    end
    
    it "should set attributes" do
      @topic = @general.topics.first
      @topic.title.should == "How does your refund policy work?"
      @topic.content.should == File.read(HelpTopic::HELP_DIR + "/refund.textile")
      @topic.should be_active
    end
    
    it "should save formatted content" do
      @topic = HelpTopic.find_by_permalink!("how-does-your-refund-policy-work")
      @topic.formatted_content.should have_tag("p", File.read(HelpTopic::HELP_DIR + "/refund.textile"))
    end
    
    it "should return the configuration file" do
      HelpTopic.instance_variable_set("@_help_config", nil)
      YAML.should_receive(:load_file).once.with(HelpTopic::CONFIG).and_return({})
      2.times { HelpTopic.config }
    end
  end
end