module HelpControllerMixin
  def index
    @categories = HelpCategory.active
  end
  
  def by_category
    @category = HelpCategory.find_by_permalink!(params[:permalink], :conditions => {:active => true})
    @topics   = @category.topics.active
  end
  
  def show
    @topic = HelpTopic.find_by_permalink!(params[:permalink], :conditions => {:active => true}, :include => :category)
    
    data = {
      :topic    => {:name => @topic.title, :content => @topic.formatted_content, :permalink => @topic.permalink},
      :category => {:name => @topic.category.title, :permalink => @topic.category.permalink}
    }
    
    respond_to do |wants|
      wants.html { 
        if request.xhr?
          render :html => content_tag(:h3, @topic.name) + @topic.formatted_content
        else
          redirect_to help_category_path(@topic.category, :anchor => @topic.permalink), :status => :moved_permanently
        end
      }
      wants.json { render :text => data.to_json }
      wants.xml  { render :xml  => data.to_xml }
    end
  end
end