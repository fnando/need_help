require File.dirname(__FILE__) + "/../spec_helper"

describe HelpController do
  integrate_views
  
  before(:each) do
    HelpTopic.import!
  end
  
  describe "GET: index" do
    before(:each) do
      get :index
    end
    
    it "should list all categories" do
      assigns[:categories].should == HelpCategory.active
      assigns[:categories].count.should == 2
    end
  end
  
  describe "GET: by_category" do
    before(:each) do
      get :by_category, :permalink => "general"
    end
    
    it "should set category" do
      assigns[:category].should == HelpCategory.find_by_permalink!("general")
    end
    
    it "should set topics" do
      assigns[:topics].should == HelpCategory.find_by_permalink!("general").topics.active
      assigns[:topics].count.should == 6
    end
  end
  
  describe "GET: show" do
    before(:each) do
      @topic = HelpTopic.find_by_permalink!("what-is-ssl")
      @category = @topic.category
    end
    
    it "should redirect to category page" do
      get :show, :permalink => "what-is-ssl"
      assigns[:topic].should == @topic
      response.should redirect_to("http://test.host/help/general#what-is-ssl")
    end
    
    it "should render html without layout" do
      xhr :get, :show, :permalink => "what-is-ssl"
      response.should_not be_redirect
    end
    
    it "should render json" do
      xhr :get, :show, :permalink => "what-is-ssl", :format => "json"
      output = ActiveSupport::JSON.decode(response.body)
      output["category"].should == {"name" => @category.title, "permalink" => @category.permalink}
      output["topic"].should == {"name" => @topic.title, "permalink" => @topic.permalink, "content" => @topic.formatted_content}
    end
    
    it "should render xml" do
      xhr :get, :show, :permalink => "what-is-ssl", :format => "xml"
      output = Hpricot::XML(response.body)
      
      (output/"category name").inner_html.should == @category.title
      (output/"category permalink").inner_html.should == @category.permalink
      
      (output/"topic name").inner_html.should == @topic.title
      (output/"topic permalink").inner_html.should == @topic.permalink
      (output/"topic content").should_not be_blank
    end
  end
end