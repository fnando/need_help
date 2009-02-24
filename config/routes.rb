ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => "help" do |url|
    url.help          "/help", :action => "index"
    url.help_category "/help/:permalink", :action => "show"
  end
end