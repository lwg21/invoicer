def color(text, color_name = :yellow)
  colors = { black: 30, red: 31, green: 32, yellow: 33, blue: 34, magenta: 35, cyan: 36, white: 37 }
  code = colors[color_name] || 0
  "\033[#{code}m#{text}\033[0m"
end

namespace :db do
  desc "Pull the production database to local environment for backup and testing"
  task :backup do
    backup_dir = "storage/backup"
    `mkdir -p "#{backup_dir}"`

    timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")

    app_name = Rails.application.class.module_parent_name.downcase
    puts "Rails app name: #{color(app_name)}"

    remote_host = Rails.application.credentials["remote_host"]
    puts "Remote host IP address: #{color(remote_host)}"

    container_id = `ssh root@#{remote_host} "docker ps -f 'name=#{app_name}' -q"`.strip
    puts "Container ID: #{color(container_id)}"

    puts "\nMaking SQLite backup…"
    backup_name = "#{timestamp}_#{app_name}_production.sqlite3"
    temp_backup_file = "/tmp/#{backup_name}"
    backup_file = "#{backup_dir}/#{backup_name}"

    `ssh root@#{remote_host} "docker exec #{container_id} sqlite3 /rails/storage/production.sqlite3 '.backup #{temp_backup_file}'"`
    puts "Backup created in Docker container: #{color(temp_backup_file, :blue)}"

    `ssh root@#{remote_host} "docker cp #{container_id}:#{temp_backup_file} #{temp_backup_file}"`
    puts "Backup created on remote: #{color(temp_backup_file, :blue)}"

    puts "\nCopying backup to local machine…"
    `scp "root@#{remote_host}:#{temp_backup_file}" "#{backup_file}"`
    puts color("Backup successfully copied!")
  end
end
