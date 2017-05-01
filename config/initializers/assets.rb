# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( bootstrap.css )
Rails.application.config.assets.precompile += %w( analytic_charts.js )
Rails.application.config.assets.precompile += %w( home.js )
Rails.application.config.assets.precompile += %w( map.js )
Rails.application.config.assets.precompile += %w( download_confirmation.js )
Rails.application.config.assets.precompile += %w( login.scss )
Rails.application.config.assets.precompile += %w( email.css )
Rails.application.config.assets.precompile += %w( .svg .eot .woff .ttf)