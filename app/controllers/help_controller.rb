class HelpController < ApplicationController
  def index
    @categories = HelpCategory.active
  end
  
  def show
    @category = HelpCategory.find_by_permalink!(params[:permalink], true)
    @topics   = @category.topics.active
  end
end