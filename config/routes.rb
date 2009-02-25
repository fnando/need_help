ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => "help" do |url|
    url.help          "/help", :action => "index"
    url.help_page     "/help/v/:permalink", :action => "show"
    url.help_category "/help/:permalink", :action => "by_category"
  end
end