require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")

namespace :help do
  desc "Sync extra files from help plugin"
  task :sync do
    system "rsync -ruv vendor/plugins/need_help/db/migrate db"
  end
  
  desc "Update Help"
  task :update do
    HelpTopic.import!
  end
end