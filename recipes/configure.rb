if node[:opsworks][:instance][:layers].include?('rails-app') || node[:opsworks][:instance][:layers].include?('rails-worker')

  include_recipe "opsworks_custom_env::restart_command"
  include_recipe "opsworks_custom_env::write_config"

end
