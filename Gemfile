source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.0"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft", "~> 1.1.0"
# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 2.7.3"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.6.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails", "~> 2.2.3"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "~> 2.0.20"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "~> 1.3.4"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", "~> 2.13.0"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache", "~> 1.0.7"
gem "solid_queue", "~> 1.1.5"
gem "solid_cable", "~> 3.0.12"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "~> 1.18.6", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", "~> 2.8.2", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", "~> 0.1.16", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", "~> 1.11.0", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", "~> 7.1.2", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", "~> 1.1.0", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console", "~> 4.2.1"
end

gem "ruby_ui", "~> 1.0.1", group: :development, require: false

gem "phlex-rails", "~> 2.3.1"

gem "tailwind_merge", "~> 1.3.1"

gem "tailwindcss-rails", "~> 4.4.0"

gem "foreman", "~> 0.88.1", group: :development

gem "bcrypt", "~> 3.1.20"

gem "rinku", "~> 2.0.6"

gem "pry-rails", "~> 0.3.11", group: :development

# gem "pry-remote", "~> 0.1.8", group: :development  # Incompatible with Ruby 4.0 (missing readline)

gem "pessimize", "~> 0.5.0", group: :development
