ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => "help" do |url|
    url.help                "/help", :action => "index"
    url.help_page           "/help/v/:permalink", :action => "show"
    url.formatted_help_page "/help/v/:permalink.:format", :action => "show"
    url.help_category       "/help/:permalink", :action => "by_category"
  end
end