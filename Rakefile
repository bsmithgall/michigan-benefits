require_relative "config/application"

task(:rubocop) do
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
end

task default: %w(spec rubocop bundler:audit)

Rails.application.load_tasks

task "db:schema:dump": "strong_migrations:alphabetize_columns"
