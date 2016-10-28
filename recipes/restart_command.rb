node[:deploy].each do |application, deploy|

  execute "restart Rails app #{application} for custom env" do
    case node[:opsworks][:instance][:layers]
    when "rails-app"
      cwd deploy[:current_path]
      if node[:opsworks][:rails_stack][:name].eql? "apache_passenger"
        command "touch #{deploy[:deploy_to]}/current/tmp/restart.txt"
      elsif node[:opsworks][:rails_stack][:name].eql? "nginx_unicorn"
        command "#{deploy[:deploy_to]}/shared/scripts/unicorn clean-restart"
      end
    when "rails-worker"
      command "sudo monit restart -g delayed_job_#{application}_group"
    end

    user deploy[:user]

    action :nothing
  end
end
