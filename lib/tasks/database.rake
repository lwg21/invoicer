class String
  def yellow
    "\033[33m#{self}\033[0m"
  end
end

namespace :db do
  desc "Pull the production database to local environment for backup and testing"
  task :root do
    backup_dir = "storage/backup"
    `mkdir -p "#{backup_dir}"`

    timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")

    app_name = Rails.application.class.module_parent_name.downcase
    puts "Rails app name: #{app_name.yellow}"

    remote_host = Rails.application.credentials["remote_host"]
    puts "Remote host IP address: #{remote_host.yellow}"

    container_id = `ssh root@#{remote_host} "docker ps -f 'name=#{app_name}' -q"`.strip
    puts "Container ID: #{container_id.yellow}"

    puts "\nMaking SQLite backup…"
    backup_name = "#{timestamp}_#{app_name}_production.sqlite3"
    temp_backup_file = "/tmp/#{backup_name}"
    backup_file = "#{backup_dir}/#{backup_name}"

    `ssh root@#{remote_host} "docker exec #{container_id} sqlite3 /rails/storage/production.sqlite3 '.backup #{temp_backup_file}'"`
    puts "Backup created in Docker container: #{temp_backup_file}"

    `ssh root@#{remote_host} "docker cp #{container_id}:#{temp_backup_file} #{temp_backup_file}"`
    puts "Backup created on remote: #{temp_backup_file}"

    puts "\nCopying backup to local machine…"
    `scp "root@#{remote_host}:#{temp_backup_file}" "#{backup_file}"`
    puts "Backup successfully copied!"
  end
end
