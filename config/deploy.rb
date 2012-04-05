set :application, "nasaknjiga.si"
set :domain, "racker-deploy"
set :deploy_to, "/webroot/nasaknjiga"
set :repository, 'git@staging:nasaknjiga.git'
set :scm, 'git'

namespace :vlad do
  
  desc "Symlinks stuff"
  remote_task :symlink do
    cmd = ""
    puts "Linking shared stuff to current release..."
    [
      ["#{shared_path}/database.yml", "#{current_release}/config"],
      ["#{shared_path}/assets", "#{current_release}/public/assets"],
    ].each do |link|
      cmd += "ln -s #{link[0]} #{link[1]}; "
    end
    run cmd
  end

  remote_task :update do 
    Rake::Task['vlad:symlink'].invoke
    Rake::Task['vlad:update_crontab'].invoke
  end
  
  desc "Update the crontab file"
  remote_task :update_crontab do
    run "cd #{current_release} && whenever --update-crontab #{application}"
  end
  
  desc "Deploy application"
  remote_task :deploy do 
    system("git push")    
    Rake::Task['vlad:update'].invoke
    Rake::Task['vlad:migrate'].invoke
    Rake::Task['vlad:start_app'].invoke
    Rake::Task['vlad:notify_hoptoad'].invoke
  end
  
  task :notify_hoptoad => [:git_user, :git_revision] do
    notify_command = "rake hoptoad:deploy TO=#{rails_env} REVISION=#{current_sha} REPO=#{repository} USER='#{current_user}'" 
    puts "Notifying Hoptoad of Deploy..." 
    `#{notify_command}`
    puts "Notify complete."
  end
  
  remote_task :git_revision do
    set :current_sha, run("cd #{File.join(scm_path, 'repo')}; git rev-parse origin/master").strip
  end
  
  task :git_user do
    set :current_user, `git config --get user.name`.strip
  end
end